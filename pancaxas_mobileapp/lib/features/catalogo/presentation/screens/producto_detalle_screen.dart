import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../carrito/presentation/utils/agregar_al_carrito.dart';
import '../providers/catalogo_providers.dart';

class ProductoDetalleScreen extends ConsumerStatefulWidget {
  final int productoId;

  const ProductoDetalleScreen({super.key, required this.productoId});

  @override
  ConsumerState<ProductoDetalleScreen> createState() => _ProductoDetalleScreenState();
}

class _ProductoDetalleScreenState extends ConsumerState<ProductoDetalleScreen> {
  int _cantidad = 1;

  @override
  Widget build(BuildContext context) {
    final productoAsync = ref.watch(productoDetalleProvider(widget.productoId));

    return Scaffold(
      backgroundColor: AppColors.crema,
      body: productoAsync.when(
        data: (producto) => CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.crema,
              expandedHeight: 260,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: producto.imagenUrl != null
                    ? CachedNetworkImage(imageUrl: producto.imagenUrl!, fit: BoxFit.cover)
                    : Container(
                        color: AppColors.crema,
                        child: const Icon(Icons.bakery_dining, size: 72, color: AppColors.dorado),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(producto.nombre,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'S/ ${producto.precio.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.dorado),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            size: 10,
                            color: producto.disponible ? AppColors.exito : AppColors.error),
                        const SizedBox(width: 6),
                        Text(producto.disponible ? 'Disponible' : 'No disponible'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (producto.descripcion != null) Text(producto.descripcion!),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cantidad', style: TextStyle(fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            IconButton(
                              onPressed:
                                  _cantidad > 1 ? () => setState(() => _cantidad--) : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('$_cantidad', style: const TextStyle(fontSize: 16)),
                            IconButton(
                              onPressed: producto.stock > _cantidad
                                  ? () => setState(() => _cantidad++)
                                  : null,
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AppPrimaryButton(
                      text: producto.disponible
                          ? 'Agregar al carrito - S/ ${(producto.precio * _cantidad).toStringAsFixed(2)}'
                          : 'No disponible',
                      onPressed: producto.disponible
                          ? () => agregarAlCarrito(context, ref, producto.id, cantidad: _cantidad)
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error al cargar el producto: $err')),
      ),
    );
  }
}
