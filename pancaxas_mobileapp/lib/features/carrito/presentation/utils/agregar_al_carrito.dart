import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/carrito_providers.dart';

Future<void> agregarAlCarrito(
  BuildContext context,
  WidgetRef ref,
  int productoId, {
  int cantidad = 1,
}) async {
  try {
    await ref
        .read(carritoControllerProvider.notifier)
        .agregarProducto(productoId: productoId, cantidad: cantidad);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto agregado al carrito'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
