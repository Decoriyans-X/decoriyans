import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Transparent Decoriyans lockup (mark + title) and mark-only variants.
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.height = 40,
    this.showMark = true,
    this.showTitle = true,
    this.onDark = false,
  });

  final double height;
  final bool showMark;
  final bool showTitle;

  /// Cream plate behind logo when shown on teal/dark surfaces.
  final bool onDark;

  String get _asset {
    if (showMark && showTitle) return 'assets/brand/logo.png';
    if (showMark) return 'assets/brand/logo_mark.png';
    return 'assets/brand/logo_title.png';
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      _asset,
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );

    if (!onDark) return image;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: height * 0.22,
        vertical: height * 0.14,
      ),
      decoration: BoxDecoration(
        color: AppColors.cream.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(height * 0.2),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: image,
    );
  }
}
