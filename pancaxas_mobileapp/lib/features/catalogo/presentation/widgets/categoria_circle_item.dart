import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/categoria_model.dart';

IconData _iconoParaCategoria(String nombre) {
  final n = nombre.toLowerCase();
  if (n.contains('pan')) return Icons.bakery_dining;
  if (n.contains('pastel')) return Icons.cake;
  if (n.contains('dulce')) return Icons.cookie;
  if (n.contains('salado')) return Icons.lunch_dining;
  if (n.contains('bebida')) return Icons.local_cafe;
  return Icons.bakery_dining;
}

class CategoriaCircleItem extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onTap;

  const CategoriaCircleItem({super.key, required this.categoria, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.crema,
              backgroundImage:
                  categoria.imagenUrl != null ? NetworkImage(categoria.imagenUrl!) : null,
              child: categoria.imagenUrl == null
                  ? Icon(_iconoParaCategoria(categoria.nombre), color: AppColors.marron)
                  : null,
            ),
            const SizedBox(height: 6),
            Text(
              categoria.nombre,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
