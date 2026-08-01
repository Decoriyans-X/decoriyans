import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/about_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';
import 'pages/product_page.dart';
import 'pages/shop_page.dart';
import 'state/cart_provider.dart';
import 'theme/app_theme.dart';
import 'widgets/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DecoriyansApp());
}

class DecoriyansApp extends StatefulWidget {
  const DecoriyansApp({super.key});

  @override
  State<DecoriyansApp> createState() => _DecoriyansAppState();
}

class _DecoriyansAppState extends State<DecoriyansApp> {
  late final CartProvider _cart;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _cart = CartProvider()..load();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/shop',
              builder: (context, state) => ShopPage(
                categoryName: state.uri.queryParameters['category'],
              ),
            ),
            GoRoute(
              path: '/product/:slug',
              builder: (context, state) => ProductPage(
                slug: state.pathParameters['slug']!,
              ),
            ),
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartPage(),
            ),
            GoRoute(
              path: '/checkout',
              builder: (context, state) => const CheckoutPage(),
            ),
            GoRoute(
              path: '/about',
              builder: (context, state) => const AboutPage(),
            ),
            GoRoute(
              path: '/contact',
              builder: (context, state) => const ContactPage(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _cart,
      child: MaterialApp.router(
        title: 'Decoriyans — crafted for you',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: _router,
      ),
    );
  }
}
