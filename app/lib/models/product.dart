enum ProductCategory {
  pottery,
  textiles,
  woodwork,
  jewelry,
  homeDecor,
  art,
}

extension ProductCategoryX on ProductCategory {
  String get label => switch (this) {
        ProductCategory.pottery => 'Pottery',
        ProductCategory.textiles => 'Textiles',
        ProductCategory.woodwork => 'Woodwork',
        ProductCategory.jewelry => 'Jewelry',
        ProductCategory.homeDecor => 'Home Décor',
        ProductCategory.art => 'Art',
      };
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.longDescription,
    required this.price,
    this.originalPrice,
    required this.category,
    required this.imageAsset,
    required this.materials,
    this.dimensions,
    required this.inStock,
    required this.featured,
    required this.rating,
    required this.reviewCount,
  });

  final String id;
  final String name;
  final String slug;
  final String description;
  final String longDescription;
  final double price;
  final double? originalPrice;
  final ProductCategory category;
  final String imageAsset;
  final List<String> materials;
  final String? dimensions;
  final bool inStock;
  final bool featured;
  final double rating;
  final int reviewCount;
}

class SiteConfig {
  static const name = 'Decoriyans';
  static const tagline = 'crafted for you';
  static const description =
      'Discover hand-drafted treasures — pottery, textiles, woodwork, jewelry, and décor made with care.';
  static const domain = 'decoriyans.com';
  static const email = 'hello@decoriyans.com';
  static const phone = '+1 (555) 234-5678';
  static const freeShippingThreshold = 75.0;
  static const standardShipping = 8.99;
}
