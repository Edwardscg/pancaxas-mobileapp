import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../carrito/presentation/utils/agregar_al_carrito.dart';
import '../../../catalogo/presentation/providers/catalogo_providers.dart';
import '../../../catalogo/presentation/widgets/producto_card.dart';

class BuscarTab extends ConsumerStatefulWidget {
  const BuscarTab({super.key});

  @override
  ConsumerState<BuscarTab> createState() => _BuscarTabState();
}

class _BuscarTabState extends ConsumerState<BuscarTab> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultadosAsync = ref.watch(busquedaProductosProvider(_query));

    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Buscar productos...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) => setState(() => _query = value.trim()),
          onChanged: (value) => setState(() => _query = value.trim()),
        ),
      ),
      body: _query.isEmpty
          ? const Center(child: Text('Escribe el nombre de un producto para buscar.'))
          : resultadosAsync.when(
              data: (productos) {
                if (productos.isEmpty) {
                  return const Center(child: Text('Sin resultados para tu búsqueda.'));
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
              error: (err, st) => Center(child: Text('Error en la búsqueda: $err')),
            ),
    );
  }
}
