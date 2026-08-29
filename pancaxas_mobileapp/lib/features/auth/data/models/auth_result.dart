import 'usuario_model.dart';

class AuthResult {
  final String token;
  final Usuario usuario;

  const AuthResult({required this.token, required this.usuario});

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      token: json['token'] as String,
      usuario: Usuario.fromAuthJson(json),
    );
  }
}
