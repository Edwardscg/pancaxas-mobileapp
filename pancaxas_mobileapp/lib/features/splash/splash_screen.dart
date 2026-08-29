import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/token_storage.dart';
import '../../core/theme/app_colors.dart';

/// Verifica conexión con el backend y si ya hay una sesión guardada,
/// para decidir a qué pantalla navegar (login o home).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _estado = 'Conectando con el backend...';

  @override
  void initState() {
    super.initState();
    // _verificarConexion();
    _inicializar();
  }

  // Future<void> _verificarConexion() async {
  //   final client = DioClient(TokenStorage());
  //   try {
  //     final response = await client.dio.get('/health');
  //     setState(() => _estado = 'Backend conectado: ${response.data}');
  //   } catch (_) {
  //     setState(() => _estado =
  //         'No se pudo conectar al backend. Revisa que esté corriendo y el API_BASE_URL configurado.');
  //   }
  // }

  Future<void> _inicializar() async {
    final tokenStorage = TokenStorage();
    final client = DioClient(tokenStorage);
    bool conectado = false;

    try {
      final response = await client.dio.get('/health');
      conectado = true;
      setState(() => _estado = 'Backend conectado: ${response.data}');
    } catch (_) {
      setState(() => _estado =
      'No se pudo conectar al backend. Revisa que esté corriendo y el API_BASE_URL configurado.');
    }

    if (!conectado || !mounted) return;

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final token = await tokenStorage.leerToken();
    if (token != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.crema,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bakery_dining, size: 64, color: AppColors.marron),
              const SizedBox(height: 16),
              const Text(
                'PanCaxas Delivery',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.marron,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _estado,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textoSecundario),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
