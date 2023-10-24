import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/cart_provider.dart';

import '../model/product.dart';

class ProductList extends StatefulWidget {
  final List<Product> products = [
    Product(id: 1, name: 'Product 1', price: 10.0),
    Product(id: 2, name: 'Product 2', price: 15.0),
    Product(id: 3, name: 'Product 3', price: 20.0),
    Product(id: 4, name: 'Product 4', price: 20.0),
    Product(id: 5, name: 'Product 5', price: 20.0),
    Product(id: 6, name: 'Product 6', price: 20.0),
    Product(id: 7, name: 'Product 7', price: 20.0),
    Product(id: 8, name: 'Product 8', price: 20.0),
    Product(id: 9, name: 'Product 9', price: 20.0),
  ];

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: const Icon(
              Icons.add_shopping_cart,
            ),
            onPressed: () {
              // CartProvider().addItemToCart(product);
              context.read<CartProvider>().addItemToCart(product);
            },
          ),
        );
      },
    );
  }
}
