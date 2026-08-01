import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key, this.categoryName});

  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    ProductCategory? selected;
    if (categoryName != null) {
      selected = ProductCategory.values
          .where((c) => c.name == categoryName)
          .firstOrNull;
    }
    final filtered = productsByCategory(selected);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            width >= 900 ? 48 : 16,
            28,
            width >= 900 ? 48 : 16,
            12,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selected?.label ?? 'All Products',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tealDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${filtered.length} handcrafted items',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        selected: selected == null,
                        onTap: () => context.go('/shop'),
                      ),
                      ...ProductCategory.values.map(
                        (c) => _FilterChip(
                          label: c.label,
                          selected: selected == c,
                          onTap: () => context.go('/shop?category=${c.name}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            width >= 900 ? 48 : 16,
            8,
            width >= 900 ? 48 : 16,
            40,
          ),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width >= 1100
                  ? 4
                  : width >= 700
                      ? 3
                      : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.68,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProductCard(product: filtered[index]),
              childCount: filtered.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.teal,
        labelStyle: TextStyle(
          color: selected ? AppColors.white : AppColors.text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
