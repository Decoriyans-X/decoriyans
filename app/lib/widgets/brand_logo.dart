import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Transparent brand assets: icon mark + wordmark title.
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

  /// When true, places the lockup on a cream plate so dark teal
  /// wordmark text stays readable on teal/dark backgrounds.
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
        horizontal: height * 0.28,
        vertical: height * 0.18,
      ),
      decoration: BoxDecoration(
        color: AppColors.cream.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(height * 0.22),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
      ),
      child: image,
    );
  }
}
