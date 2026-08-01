import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../state/cart_provider.dart';
import '../theme/app_theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final width = MediaQuery.sizeOf(context).width;

    if (cart.items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_bag_outlined,
                  size: 64, color: AppColors.muted),
              const SizedBox(height: 16),
              Text(
                'Your cart is empty',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  color: AppColors.tealDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Discover handcrafted treasures waiting for you.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.go('/shop'),
                child: const Text('Start Shopping'),
              ),
            ],
          ),
        ),
      );
    }

    final summary = _OrderSummary(cart: cart);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        width >= 900 ? 48 : 16,
        24,
        width >= 900 ? 48 : 16,
        40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shopping Cart',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.tealDark,
            ),
          ),
          const SizedBox(height: 20),
          if (width >= 900)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _CartList(cart: cart)),
                const SizedBox(width: 24),
                Expanded(child: summary),
              ],
            )
          else ...[
            _CartList(cart: cart),
            const SizedBox(height: 20),
            summary,
          ],
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({required this.cart});
  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cart.items.map((item) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.product.imageAsset,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatPrice(item.product.price),
                        style: const TextStyle(
                          color: AppColors.teal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => cart.updateQuantity(
                              item.product.id,
                              item.quantity - 1,
                            ),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            onPressed: () => cart.updateQuantity(
                              item.product.id,
                              item.quantity + 1,
                            ),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => cart.remove(item.product.id),
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.cart});
  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _row('Subtotal', formatPrice(cart.subtotal)),
            _row(
              'Shipping',
              cart.shipping == 0 ? 'Free' : formatPrice(cart.shipping),
            ),
            if (cart.shipping > 0)
              Text(
                'Free shipping over \$${SiteConfig.freeShippingThreshold.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            _row('Tax (est.)', formatPrice(cart.tax)),
            const Divider(height: 28),
            _row('Total', formatPrice(cart.total), bold: true),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
              onPressed: () => context.go('/checkout'),
              child: const Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      fontSize: bold ? 16 : 14,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
