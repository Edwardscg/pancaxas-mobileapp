import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class HomeScreenPlaceholder extends ConsumerWidget {
  const HomeScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(title: const Text('PanCaxas Delivery')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('¡Login exitoso!', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            const Text(
              'Aun no se han agregado productos..',
              style: TextStyle(color: AppColors.textoSecundario),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).cerrarSesion();
                if (context.mounted) context.go('/login');
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
