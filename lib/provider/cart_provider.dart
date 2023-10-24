import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/model/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  String _serializeCartData() {
    final cartList = _items.map((item) {
      return {
        'product_id': item.product.id,
        'quantity': item.quantity,
      };
    }).toList();
    return json.encode(cartList);
  }

  Future<void> loadCartFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final decodedCart = json.decode(cartData) as List<dynamic>;
      _items = decodedCart.map((itemData) {
        final productId = itemData['product_id'];
        final quantity = itemData['quantity'];
        final product = getProductById(productId);
        return CartItem(product: product!, quantity: quantity);
      }).toList();
    }
  }

  Product? getProductById(int id) {
    for (var item in _items) {
      if (item.product.id == id) {
        return item.product;
      }
    }

    return null;
  }

  Future<void> saveCartToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final serializedCartData = _serializeCartData();
    // Serialize _items and save to shared preferences
    prefs.setString('cart', serializedCartData);
  }

  void addItemToCart(Product product) {
    _items.add(CartItem(product: product));
    saveCartToStorage();
    notifyListeners();
    print('Addded to cart Finally with Id...${product.id}');
  }

  void removeItemFromCart(CartItem item) {
    _items.remove(item);
    saveCartToStorage();
    notifyListeners();
  }
}
