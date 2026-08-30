import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/producto_model.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTap;
  final VoidCallback? onAgregar;

  const ProductoCard({
    super.key,
    required this.producto,
    required this.onTap,
    this.onAgregar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.superficie,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borde),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: producto.imagenUrl != null
                  ? CachedNetworkImage(
                      imageUrl: producto.imagenUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: AppColors.borde),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.bakery_dining,
                        color: AppColors.dorado,
                        size: 40,
                      ),
                    )
                  : Container(
                      color: AppColors.crema,
                      child: const Icon(Icons.bakery_dining, color: AppColors.dorado, size: 40),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  if (producto.descripcion != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      producto.descripcion!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppColors.textoSecundario),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'S/ ${producto.precio.toStringAsFixed(2)}',
                        style: const TextStyle(color: AppColors.dorado, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: onAgregar ?? onTap,
                        borderRadius: BorderRadius.circular(20),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.marron,
                          child: Icon(Icons.add, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
