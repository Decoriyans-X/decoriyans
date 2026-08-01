import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final featured = featuredProducts();
    final heroHeight = width >= 900 ? 480.0 : 360.0;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: heroHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/hero-living-room.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.tealDark.withValues(alpha: 0.88),
                        AppColors.tealDark.withValues(alpha: 0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width >= 900 ? 64 : 24,
                        vertical: 32,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/brand/logo.png',
                            height: width >= 900 ? 72 : 56,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Handcrafted with soul',
                            style: GoogleFonts.playfairDisplay(
                              color: AppColors.white,
                              fontSize: width >= 900 ? 42 : 30,
                              fontWeight: FontWeight.w600,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            SiteConfig.description,
                            style: TextStyle(
                              color: AppColors.cream.withValues(alpha: 0.92),
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.gold,
                                  foregroundColor: AppColors.white,
                                ),
                                onPressed: () => context.go('/shop'),
                                child: const Text('Explore Collection'),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.white,
                                  side: const BorderSide(color: AppColors.white),
                                ),
                                onPressed: () => context.go('/about'),
                                child: const Text('Our Story'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 24,
              runSpacing: 16,
              children: const [
                _TrustItem(Icons.favorite_border, '100% Handmade'),
                _TrustItem(Icons.local_shipping_outlined, 'Free shipping \$75+'),
                _TrustItem(Icons.verified_outlined, 'Curated craftsmanship'),
                _TrustItem(Icons.lock_outline, 'Secure checkout'),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            width >= 900 ? 48 : 16,
            40,
            width >= 900 ? 48 : 16,
            16,
          ),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Featured Treasures',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tealDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Handpicked pieces for your space',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/shop'),
                  child: const Text('View all'),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            width >= 900 ? 48 : 16,
            0,
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
              (context, index) => ProductCard(product: featured[index]),
              childCount: featured.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.creamDark,
            padding: EdgeInsets.symmetric(
              vertical: 48,
              horizontal: width >= 900 ? 48 : 16,
            ),
            child: Column(
              children: [
                Text(
                  'Shop by Category',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tealDark,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: ProductCategory.values.map((c) {
                    return ActionChip(
                      label: Text(c.label),
                      backgroundColor: AppColors.white,
                      side: const BorderSide(color: AppColors.tealSoft),
                      onPressed: () => context.go('/shop?category=${c.name}'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            color: AppColors.teal,
            padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
            child: Column(
              children: [
                Text(
                  'crafted for you',
                  style: GoogleFonts.greatVibes(
                    color: AppColors.goldLight,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Every piece tells a story of skilled hands and lasting beauty.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.cream, fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                  ),
                  onPressed: () => context.go('/contact'),
                  child: const Text('Get in Touch'),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: _Footer()),
      ],
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.teal, size: 22),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.tealDark,
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tealDark,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        children: [
          Image.asset('assets/brand/logo.png', height: 48),
          const SizedBox(height: 12),
          Text(
            '© ${DateTime.now().year} Decoriyans · ${SiteConfig.domain}',
            style: const TextStyle(color: AppColors.cream, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
