import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).primaryColor.withValues(alpha: .15),
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Color(0xFF45483C)),
            selectedIcon: Icon(Icons.home, color: Color(0xFF3E5219)),
            label: 'Ana Səhifə',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border, color: Color(0xFF45483C)),
            selectedIcon: Icon(Icons.favorite, color: Color(0xFF9F402D)),
            label: 'Favoritlər',
          ),
          NavigationDestination(
            icon: Icon(Icons.search, color: Color(0xFF45483C)),
            selectedIcon: Icon(Icons.search, color: Color(0xFF3E5219)),
            label: 'Axtarış',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/favorites')) return 1;
    if (location.startsWith('/search')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/favorites');
        break;
      case 2:
        context.go('/search');
        break;
    }
  }
}
