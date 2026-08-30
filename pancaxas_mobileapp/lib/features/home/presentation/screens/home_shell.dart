import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../carrito/presentation/providers/carrito_providers.dart';
import '../../../carrito/presentation/screens/carrito_tab.dart';
import 'home_tab.dart';
import 'pedidos_tab_placeholder.dart';
import 'perfil_tab.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _indice = 0;

  void _irATab(int index) => setState(() => _indice = index);

  @override
  Widget build(BuildContext context) {
    final contadorCarrito = ref.watch(carritoContadorProvider);

    final tabs = [
      HomeTab(onAbrirCarrito: () => _irATab(2)),
      const PedidosTabPlaceholder(),
      const CarritoTab(),
      const PerfilTab(),
    ];

    return Scaffold(
      body: IndexedStack(index: _indice, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: _irATab,
        backgroundColor: AppColors.crema,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('$contadorCarrito'),
              isLabelVisible: contadorCarrito > 0,
              child: const Icon(Icons.shopping_basket_outlined),
            ),
            selectedIcon: Badge(
              label: Text('$contadorCarrito'),
              isLabelVisible: contadorCarrito > 0,
              child: const Icon(Icons.shopping_basket),
            ),
            label: 'Carrito',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
