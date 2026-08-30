import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PedidosTabPlaceholder extends StatelessWidget {
  const PedidosTabPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(title: const Text('Mis pedidos')),
      body: const Center(
        child: Text('Historial de pedidos en desarollo.'),
      ),
    );
  }
}
