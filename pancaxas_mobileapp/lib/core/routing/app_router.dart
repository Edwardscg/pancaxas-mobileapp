import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_shell.dart';
import '../../features/home/presentation/screens/buscar_tab.dart';
import '../../features/catalogo/presentation/screens/categoria_screen.dart';
import '../../features/catalogo/presentation/screens/producto_detalle_screen.dart';

/// Definición central de rutas. Cada fase agrega sus pantallas aquí,
/// no se reescribe este archivo desde cero.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/registro',
      name: 'registro',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeShell(),
    ),
    GoRoute(
      path: '/buscar',
      name: 'buscar',
      builder: (context, state) => const BuscarTab(),
    ),
    GoRoute(
      path: '/categoria/:id',
      name: 'categoria',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final nombre = state.extra as String?;
        return CategoriaScreen(categoriaId: id, categoriaNombre: nombre);
      },
    ),
    GoRoute(
      path: '/producto/:id',
      name: 'producto',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductoDetalleScreen(productoId: id);
      },
    ),
  ],
);
