import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/cart_provider.dart';
import '../theme/app_theme.dart';
import 'brand_logo.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  bool _isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;

  @override
  Widget build(BuildContext context) {
    final wide = _isWide(context);
    final cart = context.watch<CartProvider>();
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: wide ? 24 : 0,
        title: InkWell(
          onTap: () => context.go('/'),
          borderRadius: BorderRadius.circular(10),
          child: BrandLogo(
            height: wide ? 42 : 34,
            showTitle: wide,
            onDark: true,
          ),
        ),
        actions: [
          if (wide) ...[
            _NavLink(label: 'Shop', path: '/shop', current: location),
            _NavLink(label: 'Our Story', path: '/about', current: location),
            _NavLink(label: 'Contact', path: '/contact', current: location),
            const SizedBox(width: 8),
          ],
          IconButton(
            tooltip: 'Cart',
            onPressed: () => context.go('/cart'),
            icon: Badge(
              isLabelVisible: cart.itemCount > 0,
              label: Text('${cart.itemCount}'),
              backgroundColor: AppColors.gold,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          if (!wide)
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) => context.go(value),
              itemBuilder: (context) => const [
                PopupMenuItem(value: '/', child: Text('Home')),
                PopupMenuItem(value: '/shop', child: Text('Shop')),
                PopupMenuItem(value: '/about', child: Text('Our Story')),
                PopupMenuItem(value: '/contact', child: Text('Contact')),
                PopupMenuItem(value: '/cart', child: Text('Cart')),
              ],
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: child,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _tabIndex(location),
              onDestinationSelected: (i) {
                switch (i) {
                  case 0:
                    context.go('/');
                  case 1:
                    context.go('/shop');
                  case 2:
                    context.go('/cart');
                  case 3:
                    context.go('/about');
                }
              },
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view),
                  label: 'Shop',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: cart.itemCount > 0,
                    label: Text('${cart.itemCount}'),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                  selectedIcon: const Icon(Icons.shopping_bag),
                  label: 'Cart',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: 'Story',
                ),
              ],
            ),
    );
  }

  int _tabIndex(String location) {
    if (location.startsWith('/shop') || location.startsWith('/product')) {
      return 1;
    }
    if (location.startsWith('/cart') || location.startsWith('/checkout')) {
      return 2;
    }
    if (location.startsWith('/about') || location.startsWith('/contact')) {
      return 3;
    }
    return 0;
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.path,
    required this.current,
  });

  final String label;
  final String path;
  final String current;

  @override
  Widget build(BuildContext context) {
    final active = current == path || current.startsWith('$path/');
    return TextButton(
      onPressed: () => context.go(path),
      child: Text(
        label,
        style: TextStyle(
          color: active ? AppColors.goldLight : AppColors.white,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}
