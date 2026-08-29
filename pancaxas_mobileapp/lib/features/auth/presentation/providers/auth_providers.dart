import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/token_storage.dart';
import '../../data/auth_repository.dart';
import '../../data/models/usuario_model.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final dioClientProvider = Provider<DioClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return DioClient(tokenStorage);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioClientProvider), ref.watch(tokenStorageProvider));
});

enum AuthStatus { desconocido, autenticado, noAutenticado }

class AuthState {
  final AuthStatus status;
  final Usuario? usuario;
  final String? error;

  const AuthState({required this.status, this.usuario, this.error});

  const AuthState.desconocido() : this(status: AuthStatus.desconocido);
  const AuthState.noAutenticado() : this(status: AuthStatus.noAutenticado);
  const AuthState.autenticado(Usuario usuario)
      : this(status: AuthStatus.autenticado, usuario: usuario);
}

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AuthState.desconocido());

  Future<void> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    String? telefono,
  }) async {
    final resultado = await _repository.registrar(
      nombre: nombre,
      apellido: apellido,
      correo: correo,
      password: password,
      telefono: telefono,
    );
    state = AuthState.autenticado(resultado.usuario);
  }

  Future<void> iniciarSesion({required String correo, required String password}) async {
    final resultado = await _repository.iniciarSesion(correo: correo, password: password);
    state = AuthState.autenticado(resultado.usuario);
  }

  Future<void> cerrarSesion() async {
    await _repository.cerrarSesion();
    state = const AuthState.noAutenticado();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});
