import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/carrito_item_model.dart';

class CarritoItemTile extends StatelessWidget {
  final CarritoItemModelo item;
  final ValueChanged<int> onCambiarCantidad;
  final VoidCallback onEliminar;

  const CarritoItemTile({
    super.key,
    required this.item,
    required this.onCambiarCantidad,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: item.productoImagenUrl != null
                  ? CachedNetworkImage(imageUrl: item.productoImagenUrl!, fit: BoxFit.cover)
                  : Container(
                      color: AppColors.crema,
                      child: const Icon(Icons.bakery_dining, color: AppColors.dorado),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.productoNombre,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    InkWell(
                      onTap: onEliminar,
                      child: const Icon(Icons.delete_outline,
                          size: 20, color: AppColors.textoSecundario),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'S/ ${item.precioUnitario.toStringAsFixed(2)}',
                  style: const TextStyle(color: AppColors.dorado, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.crema,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed:
                            item.cantidad > 1 ? () => onCambiarCantidad(item.cantidad - 1) : null,
                        icon: const Icon(Icons.remove, size: 18),
                      ),
                      Text('${item.cantidad}', style: const TextStyle(fontWeight: FontWeight.w600)),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => onCambiarCantidad(item.cantidad + 1),
                        icon: const Icon(Icons.add, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
