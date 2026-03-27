import '../services/supabase_service.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import 'login_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الدخول مطلوب'),
        content: const Text('يرجى تسجيل الدخول للمتابعة'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            child: const Text('تسجيل الدخول'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(p.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (p.images.isNotEmpty)
              Image.network(p.images.first, height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(p.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${p.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 20, color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(p.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text('الكمية:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 16),
                        onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                      ),
                      SizedBox(width: 40, child: Center(child: Text('$_quantity'))),
                      IconButton(
                        icon: const Icon(Icons.add, size: 16),
                        onPressed: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'اشتر الآن',
              onPressed: () {
                if (!SupabaseService.isAuthenticated) {
                  _showLoginDialog();
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
