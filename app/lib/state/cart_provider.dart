import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/products.dart';
import '../models/product.dart';

class CartItem {
  CartItem({required this.product, required this.quantity});

  final Product product;
  int quantity;

  Map<String, dynamic> toJson() => {
        'productId': product.id,
        'quantity': quantity,
      };
}

class CartProvider extends ChangeNotifier {
  static const _storageKey = 'decoriyans-cart-v2';

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);

  double get subtotal =>
      _items.fold(0, (sum, i) => sum + i.product.price * i.quantity);

  double get shipping => subtotal >= SiteConfig.freeShippingThreshold
      ? 0
      : (subtotal == 0 ? 0 : SiteConfig.standardShipping);

  double get tax => subtotal * 0.08;

  double get total => subtotal + shipping + tax;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;
    final list = jsonDecode(raw) as List<dynamic>;
    _items
      ..clear()
      ..addAll(list.map((e) {
        final map = e as Map<String, dynamic>;
        final product = products.firstWhere((p) => p.id == map['productId']);
        return CartItem(product: product, quantity: map['quantity'] as int);
      }));
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(_items.map((e) => e.toJson()).toList()),
    );
  }

  void add(Product product, {int quantity = 1}) {
    final existing = _items.where((i) => i.product.id == product.id);
    if (existing.isNotEmpty) {
      existing.first.quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    _persist();
    notifyListeners();
  }

  void remove(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    _persist();
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    final item = _items.firstWhere((i) => i.product.id == productId);
    item.quantity = quantity;
    _persist();
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _persist();
    notifyListeners();
  }
}
