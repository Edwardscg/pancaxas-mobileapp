import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class PerfilTab extends ConsumerWidget {
  const PerfilTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final usuario = authState.usuario;
    final inicial = (usuario != null && usuario.nombre.isNotEmpty)
        ? usuario.nombre[0].toUpperCase()
        : '?';

    return Scaffold(
      backgroundColor: AppColors.crema,
      appBar: AppBar(title: const Text('Mi perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.marron,
            child: Text(inicial, style: const TextStyle(color: Colors.white, fontSize: 28)),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              usuario?.nombre ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              usuario?.correo ?? '',
              style: const TextStyle(color: AppColors.textoSecundario),
            ),
          ),
          const SizedBox(height: 32),
          const ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Mis direcciones, en desarrollo.'),
          ),
          const ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text('Métodos de pago, en desarrollo.'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Cerrar sesión', style: TextStyle(color: AppColors.error)),
            onTap: () async {
              await ref.read(authControllerProvider.notifier).cerrarSesion();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
