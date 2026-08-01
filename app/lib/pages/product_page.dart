import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../state/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final product = productBySlug(slug);
    if (product == null) {
      return const Center(child: Text('Product not found'));
    }

    final width = MediaQuery.sizeOf(context).width;
    final related = products
        .where((p) => p.category == product.category && p.id != product.id)
        .take(4)
        .toList();

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.category.label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: AppColors.tealDark,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, size: 18, color: AppColors.gold),
            const SizedBox(width: 6),
            Text('${product.rating} (${product.reviewCount} reviews)'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              formatPrice(product.price),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.teal,
              ),
            ),
            if (product.originalPrice != null) ...[
              const SizedBox(width: 10),
              Text(
                formatPrice(product.originalPrice!),
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.muted,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          product.longDescription,
          style: const TextStyle(height: 1.55, color: AppColors.text),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: product.materials
              .map(
                (m) => Chip(
                  label: Text(m),
                  backgroundColor: AppColors.creamDark,
                  side: BorderSide.none,
                ),
              )
              .toList(),
        ),
        if (product.dimensions != null) ...[
          const SizedBox(height: 12),
          Text('Dimensions: ${product.dimensions}'),
        ],
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: product.inStock
                ? () {
                    context.read<CartProvider>().add(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        action: SnackBarAction(
                          label: 'View cart',
                          onPressed: () => context.go('/cart'),
                        ),
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.shopping_bag_outlined),
            label: Text(product.inStock ? 'Add to Cart' : 'Out of Stock'),
          ),
        ),
      ],
    );

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
          TextButton.icon(
            onPressed: () => context.go('/shop'),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Shop'),
          ),
          const SizedBox(height: 8),
          if (width >= 900)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(product.imageAsset, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(child: details),
              ],
            )
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(product.imageAsset, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            details,
          ],
          if (related.isNotEmpty) ...[
            const SizedBox(height: 48),
            Text(
              'You May Also Like',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.tealDark,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: related.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width >= 900 ? 4 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, i) => ProductCard(product: related[i]),
            ),
          ],
        ],
      ),
    );
  }
}
