import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import 'models/auth_result.dart';

class AuthRepository {
  final DioClient _client;
  final TokenStorage _tokenStorage;

  AuthRepository(this._client, this._tokenStorage);

  Future<AuthResult> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    String? telefono,
  }) async {
    try {
      final response = await _client.dio.post('/auth/registro', data: {
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'password': password,
        if (telefono != null && telefono.isNotEmpty) 'telefono': telefono,
      });

      final resultado = AuthResult.fromJson(response.data as Map<String, dynamic>);
      await _tokenStorage.guardarToken(resultado.token);
      return resultado;
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<AuthResult> iniciarSesion({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await _client.dio.post('/auth/login', data: {
        'correo': correo,
        'password': password,
      });

      final resultado = AuthResult.fromJson(response.data as Map<String, dynamic>);
      await _tokenStorage.guardarToken(resultado.token);
      return resultado;
    } on DioException catch (e) {
      throw _client.traducirError(e);
    }
  }

  Future<void> cerrarSesion() => _tokenStorage.borrarToken();

  Future<bool> haySesionActiva() async {
    final token = await _tokenStorage.leerToken();
    return token != null;
  }
}
