import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/brand/logo.png', height: 64),
              const SizedBox(height: 24),
              Text(
                'Our Story',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: AppColors.tealDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                SiteConfig.tagline,
                style: GoogleFonts.greatVibes(
                  fontSize: 28,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Decoriyans was born from a simple belief: the objects we live with should carry meaning, history, and the touch of human hands.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 16),
              const Text(
                'We curate hand-drafted pottery, textiles, woodwork, jewelry, décor, and art from skilled craftspeople — never factory-made, never anonymous. Deep teal and warm gold guide our brand: grounded craftsmanship with a luminous finish.',
                style: TextStyle(height: 1.6, color: AppColors.muted),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: const [
                  _Stat('150+', 'Artisan partners'),
                  _Stat('32', 'Countries'),
                  _Stat('12K+', 'Happy customers'),
                  _Stat('4.9', 'Avg. rating'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.creamDark),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.teal,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
