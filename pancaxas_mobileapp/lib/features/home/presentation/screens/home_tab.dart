import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../carrito/presentation/providers/carrito_providers.dart';
import '../../../carrito/presentation/utils/agregar_al_carrito.dart';
import '../../../catalogo/presentation/providers/catalogo_providers.dart';
import '../../../catalogo/presentation/widgets/categoria_circle_item.dart';
import '../../../catalogo/presentation/widgets/producto_card.dart';

class HomeTab extends ConsumerWidget {
  final VoidCallback? onAbrirCarrito;

  const HomeTab({super.key, this.onAbrirCarrito});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriasAsync = ref.watch(categoriasProvider);
    final productosAsync = ref.watch(productosPorCategoriaProvider(null));
    final contadorCarrito = ref.watch(carritoContadorProvider);

    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(
        title: const Text('PanCaxas'),
        actions: [
          IconButton(
            onPressed: () => context.push('/buscar'),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: onAbrirCarrito,
            icon: Badge(
              label: Text('$contadorCarrito'),
              isLabelVisible: contadorCarrito > 0,
              child: const Icon(Icons.shopping_basket_outlined),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(categoriasProvider);
          ref.invalidate(productosPorCategoriaProvider(null));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Categorías', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            SizedBox(
              height: 96,
              child: categoriasAsync.when(
                data: (categorias) => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categorias.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final categoria = categorias[index];
                    return CategoriaCircleItem(
                      categoria: categoria,
                      onTap: () =>
                          context.push('/categoria/${categoria.id}', extra: categoria.nombre),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, st) => Text('No se pudieron cargar las categorías: $err'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Los más pedidos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            productosAsync.when(
              data: (productos) => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Text('No se pudieron cargar los productos: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
