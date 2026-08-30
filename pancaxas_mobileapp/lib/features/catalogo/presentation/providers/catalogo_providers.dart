import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/catalogo_repository.dart';
import '../../data/models/categoria_model.dart';
import '../../data/models/producto_model.dart';

final catalogoRepositoryProvider = Provider<CatalogoRepository>((ref) {
  return CatalogoRepository(ref.watch(dioClientProvider));
});

final categoriasProvider = FutureProvider<List<Categoria>>((ref) {
  return ref.watch(catalogoRepositoryProvider).listarCategorias();
});

/// categoriaId == null trae todos los productos disponibles (usado en Home).
final productosPorCategoriaProvider =
    FutureProvider.family<List<Producto>, int?>((ref, categoriaId) {
  return ref.watch(catalogoRepositoryProvider).listarProductos(categoriaId: categoriaId);
});

final productoDetalleProvider = FutureProvider.family<Producto, int>((ref, productoId) {
  return ref.watch(catalogoRepositoryProvider).obtenerDetalle(productoId);
});

final busquedaProductosProvider =
    FutureProvider.family<List<Producto>, String>((ref, query) {
  if (query.trim().isEmpty) return Future.value(<Producto>[]);
  return ref.watch(catalogoRepositoryProvider).buscar(query);
});
