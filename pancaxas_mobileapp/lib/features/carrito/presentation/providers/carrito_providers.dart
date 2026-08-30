import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/carrito_repository.dart';
import '../../data/models/carrito_model.dart';

final carritoRepositoryProvider = Provider<CarritoRepository>((ref) {
  return CarritoRepository(ref.watch(dioClientProvider));
});

class CarritoController extends StateNotifier<AsyncValue<CarritoModelo>> {
  final CarritoRepository _repository;

  CarritoController(this._repository) : super(const AsyncValue.loading()) {
    cargar();
  }

  Future<void> cargar() async {
    state = const AsyncValue.loading();
    try {
      final carrito = await _repository.obtenerCarrito();
      state = AsyncValue.data(carrito);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> agregarProducto({required int productoId, required int cantidad}) async {
    final carrito = await _repository.agregarProducto(productoId: productoId, cantidad: cantidad);
    state = AsyncValue.data(carrito);
  }

  Future<void> actualizarCantidad({required int itemId, required int cantidad}) async {
    final carrito = await _repository.actualizarCantidad(itemId: itemId, cantidad: cantidad);
    state = AsyncValue.data(carrito);
  }

  Future<void> eliminarItem(int itemId) async {
    final carrito = await _repository.eliminarItem(itemId);
    state = AsyncValue.data(carrito);
  }

  Future<void> vaciar() async {
    await _repository.vaciarCarrito();
    await cargar();
  }
}

final carritoControllerProvider =
    StateNotifierProvider<CarritoController, AsyncValue<CarritoModelo>>((ref) {
  return CarritoController(ref.watch(carritoRepositoryProvider));
});

/// Total de ítems para el badge del ícono del carrito (Home y bottom nav).
final carritoContadorProvider = Provider<int>((ref) {
  final carritoAsync = ref.watch(carritoControllerProvider);
  return carritoAsync.maybeWhen(data: (c) => c.totalItems, orElse: () => 0);
});
