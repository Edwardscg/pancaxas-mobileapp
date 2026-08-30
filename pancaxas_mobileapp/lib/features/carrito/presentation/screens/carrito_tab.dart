import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../providers/carrito_providers.dart';
import '../widgets/carrito_item_tile.dart';

/// Costo de envío fijo del MVP (igual al que usa el backend en el checkout).
const _costoEnvio = 5.00;

class CarritoTab extends ConsumerWidget {
  const CarritoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carritoAsync = ref.watch(carritoControllerProvider);
    final controller = ref.read(carritoControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(title: const Text('Carrito')),
      body: carritoAsync.when(
        data: (carrito) {
          if (carrito.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_basket_outlined, size: 64, color: AppColors.textoSecundario),
                  SizedBox(height: 12),
                  Text('Tu carrito está vacío'),
                ],
              ),
            );
          }

          final total = carrito.subtotal + _costoEnvio;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: carrito.items.length,
                  itemBuilder: (context, index) {
                    final item = carrito.items[index];
                    return CarritoItemTile(
                      item: item,
                      onCambiarCantidad: (nuevaCantidad) async {
                        try {
                          await controller.actualizarCantidad(
                            itemId: item.itemId,
                            cantidad: nuevaCantidad,
                          );
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }
                      },
                      onEliminar: () => controller.eliminarItem(item.itemId),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.dorado.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _filaResumen('Subtotal', carrito.subtotal),
                    const SizedBox(height: 6),
                    _filaResumen('Envío', _costoEnvio),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(color: AppColors.borde),
                    ),
                    _filaResumen('Total', total, destacado: true),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppPrimaryButton(
                    text: 'Ir a pagar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checkout en proceso de conexion.')),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('No se pudo cargar el carrito: $err')),
      ),
    );
  }

  Widget _filaResumen(String label, double valor, {bool destacado = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
            fontSize: destacado ? 16 : 14,
          ),
        ),
        Text(
          'S/ ${valor.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: destacado ? 18 : 14,
            color: destacado ? AppColors.dorado : AppColors.textoPrincipal,
          ),
        ),
      ],
    );
  }
}
