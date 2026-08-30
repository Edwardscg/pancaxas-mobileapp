import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../carrito/presentation/utils/agregar_al_carrito.dart';
import '../providers/catalogo_providers.dart';
import '../widgets/producto_card.dart';

class CategoriaScreen extends ConsumerWidget {
  final int categoriaId;
  final String? categoriaNombre;

  const CategoriaScreen({super.key, required this.categoriaId, this.categoriaNombre});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productosPorCategoriaProvider(categoriaId));

    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(title: Text(categoriaNombre ?? 'Categoría')),
      body: productosAsync.when(
        data: (productos) {
          if (productos.isEmpty) {
            return const Center(child: Text('No hay productos disponibles en esta categoría.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: productos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ProductoCard(
                producto: producto,
                onTap: () => context.push('/producto/${producto.id}'),
                onAgregar: () => agregarAlCarrito(context, ref, producto.id),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error al cargar productos: $err')),
      ),
    );
  }
}
