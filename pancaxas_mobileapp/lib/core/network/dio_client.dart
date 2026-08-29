import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';

/// Cliente HTTP centralizado. Agrega automáticamente el JWT a cada
/// request y traduce los errores del backend a ApiException.
class DioClient {
  final Dio dio;
  final TokenStorage _tokenStorage;

  DioClient(this._tokenStorage)
      : dio = Dio(BaseOptions(
          baseUrl: AppConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokenStorage.leerToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          await _tokenStorage.borrarToken();
        }
        handler.next(error);
      },
    ));
  }

  /// Convierte cualquier DioException en una ApiException legible,
  /// usando el mismo formato de ApiError que devuelve el backend.
  ApiException traducirError(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final mensaje = data['message'] as String? ?? 'Ocurrió un error inesperado';
      final detallesRaw = data['detalles'] as List?;
      final detalles = detallesRaw?.map((e) => e.toString()).toList();
      return ApiException(
        message: mensaje,
        statusCode: error.response?.statusCode,
        detalles: detalles,
      );
    }
    return ApiException(
      message: error.message ?? 'No se pudo conectar con el servidor',
      statusCode: error.response?.statusCode,
    );
  }
}
