import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductsScreen extends StatelessWidget {
  final String? category;
  final String? searchQuery;
  const ProductsScreen({super.key, this.category, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category ?? 'المنتجات')),
      body: const Center(child: Text('المنتجات')),
    );
  }
}
