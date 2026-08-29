import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Guarda el JWT de forma segura (Keystore en Android), nunca en
/// SharedPreferences plano.
class TokenStorage {
  static const _keyToken = 'pancaja_token';
  final FlutterSecureStorage _storage;

  TokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> guardarToken(String token) =>
      _storage.write(key: _keyToken, value: token);

  Future<String?> leerToken() => _storage.read(key: _keyToken);

  Future<void> borrarToken() => _storage.delete(key: _keyToken);
}
