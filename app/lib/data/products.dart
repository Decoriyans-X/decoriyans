import '../models/product.dart';

const products = <Product>[
  Product(
    id: 'p1',
    name: 'Terracotta Sunrise Bowl',
    slug: 'terracotta-sunrise-bowl',
    description: 'Hand-thrown bowl with a warm sunrise glaze.',
    longDescription:
        'Individually thrown and wood-fired, each bowl carries a unique glaze pattern inspired by golden-hour light. Food-safe and microwave-friendly.',
    price: 68,
    originalPrice: 85,
    category: ProductCategory.pottery,
    imageAsset: 'assets/images/product-terracotta-bowl.png',
    materials: ['Terracotta clay', 'Natural mineral glaze'],
    dimensions: '8" × 3"',
    inStock: true,
    featured: true,
    rating: 4.9,
    reviewCount: 47,
  ),
  Product(
    id: 'p2',
    name: 'Teal & Gold Woven Runner',
    slug: 'teal-gold-woven-runner',
    description: 'Handwoven runner in deep teal, gold, and cream.',
    longDescription:
        'Woven on a traditional loom with plant-dyed cotton. Diamond motifs celebrate protection and prosperity. About 40 hours of craftsmanship per piece.',
    price: 124,
    category: ProductCategory.textiles,
    imageAsset: 'assets/images/product-woven-runner.png',
    materials: ['100% cotton', 'Natural plant dyes'],
    dimensions: '72" × 14"',
    inStock: true,
    featured: true,
    rating: 5.0,
    reviewCount: 32,
  ),
  Product(
    id: 'p3',
    name: 'Ebony Carved Serving Board',
    slug: 'ebony-carved-serving-board',
    description: 'Sculptural serving board from sustainably sourced ebony.',
    longDescription:
        'Carved from a single piece of ebony with an organic live edge. Finished with food-grade mineral oil for lasting beauty.',
    price: 156,
    category: ProductCategory.woodwork,
    imageAsset: 'assets/images/product-ebony-board.png',
    materials: ['Sustainable ebony', 'Food-grade oil'],
    dimensions: '18" × 10"',
    inStock: true,
    featured: true,
    rating: 4.8,
    reviewCount: 28,
  ),
  Product(
    id: 'p4',
    name: 'Moonstone Drop Earrings',
    slug: 'moonstone-drop-earrings',
    description: 'Ethically sourced moonstone in recycled silver.',
    longDescription:
        'Hand-selected moonstones with a soft blue flash, set in recycled sterling silver. Minimalist and hypoallergenic.',
    price: 89,
    category: ProductCategory.jewelry,
    imageAsset: 'assets/images/product-moonstone-earrings.png',
    materials: ['Recycled sterling silver', 'Moonstone'],
    dimensions: '1.5" drop',
    inStock: true,
    featured: true,
    rating: 4.9,
    reviewCount: 61,
  ),
  Product(
    id: 'p5',
    name: 'Urushi Lacquer Vase',
    slug: 'urushi-lacquer-vase',
    description: 'Traditional lacquer vase with gold leaf accents.',
    longDescription:
        'Over 30 layers of natural urushi lacquer, polished by hand. Gold leaf accents applied with traditional techniques.',
    price: 320,
    category: ProductCategory.homeDecor,
    imageAsset: 'assets/images/product-lacquer-vase.png',
    materials: ['Urushi lacquer', 'Gold leaf', 'Paulownia wood'],
    dimensions: '10" height',
    inStock: true,
    featured: false,
    rating: 5.0,
    reviewCount: 14,
  ),
  Product(
    id: 'p6',
    name: 'Heritage Canvas Print',
    slug: 'heritage-canvas-print',
    description: 'Limited edition signed canvas in teal and gold.',
    longDescription:
        'Archival cotton canvas with pigment inks rated for 100+ years. Hand-signed and numbered edition of 100.',
    price: 195,
    category: ProductCategory.art,
    imageAsset: 'assets/images/product-canvas-art.png',
    materials: ['Archival cotton canvas', 'Pigment inks'],
    dimensions: '24" × 36"',
    inStock: true,
    featured: false,
    rating: 4.7,
    reviewCount: 19,
  ),
  Product(
    id: 'p7',
    name: 'Botanical Ceramic Mug Set',
    slug: 'botanical-ceramic-mug-set',
    description: 'Set of 4 hand-stamped mugs with sage-teal glaze.',
    longDescription:
        'Hand-stamped botanical motifs on stoneware with a matte sage-teal glaze. Each mug holds 12 oz and is dishwasher-safe.',
    price: 96,
    category: ProductCategory.pottery,
    imageAsset: 'assets/images/product-mug-set.png',
    materials: ['Stoneware clay', 'Matte glaze'],
    dimensions: '3.5" × 4" each',
    inStock: true,
    featured: false,
    rating: 4.8,
    reviewCount: 53,
  ),
  Product(
    id: 'p8',
    name: 'Macramé Wall Hanging',
    slug: 'macrame-wall-hanging',
    description: 'Cream and gold cotton wall hanging with wooden beads.',
    longDescription:
        'Traditional macramé knotting with hand-dyed cotton cords. Soft gold tones and wooden beads add warmth to any wall.',
    price: 78,
    category: ProductCategory.homeDecor,
    imageAsset: 'assets/images/product-wall-hanging.png',
    materials: ['Natural cotton', 'Wooden beads'],
    dimensions: '36" × 18"',
    inStock: true,
    featured: false,
    rating: 4.6,
    reviewCount: 37,
  ),
];

Product? productBySlug(String slug) {
  try {
    return products.firstWhere((p) => p.slug == slug);
  } catch (_) {
    return null;
  }
}

List<Product> featuredProducts() =>
    products.where((p) => p.featured).toList();

List<Product> productsByCategory(ProductCategory? category) {
  if (category == null) return products;
  return products.where((p) => p.category == category).toList();
}

String formatPrice(double price) => '\$${price.toStringAsFixed(2)}';
