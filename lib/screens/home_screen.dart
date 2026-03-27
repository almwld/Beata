import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/ad_card.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _products = [
      ProductModel(
        id: '1',
        title: 'آيفون 15 برو ماكس',
        description: 'هاتف أيفون جديد',
        price: 450000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300'],
        category: 'إلكترونيات',
        sellerId: '1',
        sellerName: 'متجر التقنية',
        createdAt: DateTime.now(),
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return AdCard(product: _products[index], onTap: () {});
        },
      ),
    );
  }
}
