/// Excepción de dominio para errores de la API, mapeada desde el formato
/// uniforme de error que devuelve el backend (ver ApiError.java /
/// GlobalExceptionHandler.java).
class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final List<String>? detalles;

  ApiException({required this.message, this.statusCode, this.detalles});

  @override
  String toString() => message;
}
