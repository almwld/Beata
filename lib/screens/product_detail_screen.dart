import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import 'checkout_screen.dart';
import 'login_screen.dart';
import 'product_review_screen.dart';
import 'chat_detail_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});
  @override State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // ... existing code ...

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الدخول مطلوب'),
        content: const Text('يرجى تسجيل الدخول للإضافة للمفضلة'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())); }, child: const Text('تسجيل الدخول')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ... SliverAppBar code ...
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ... existing code ...
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${p.rating.toStringAsFixed(1)} (${p.reviewCount} تقييم)', style: TextStyle(color: Colors.grey[600])),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductReviewScreen(product: p))),
                        child: const Text('أضف تقييمك', style: TextStyle(color: AppTheme.goldColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: const Icon(Icons.store, color: AppTheme.goldColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  const Icon(Icons.star, size: 12, color: Colors.amber),
                                  const SizedBox(width: 2),
                                  Text('${p.sellerRating}'),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.verified, size: 12, color: Colors.blue),
                                  const Text(' بائع موثوق'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat, color: AppTheme.goldColor),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: {"name": p.sellerName, "id": p.sellerId})),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(p.inStock ? Icons.check_circle : Icons.cancel, color: p.inStock ? Colors.green : Colors.red),
                        const SizedBox(width: 12),
                        Text(p.inStock ? 'متوفر في المخزون' : 'غير متوفر حالياً', style: TextStyle(color: p.inStock ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(p.description, style: const TextStyle(height: 1.5)),
                  const SizedBox(height: 16),
                  if (p.inStock)
                    Row(
                      children: [
                        const Text('الكمية:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              IconButton(icon: const Icon(Icons.remove, size: 16), onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null),
                              Container(width: 40, alignment: Alignment.center, child: Text('$_quantity')),
                              IconButton(icon: const Icon(Icons.add, size: 16), onPressed: () => setState(() => _quantity++)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  if (_related.isNotEmpty) ...[
                    const Text('منتجات مشابهة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    // ... related products code ...
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: p.inStock
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'اشتر الآن',
                        onPressed: () {
                          if (!SupabaseService.isAuthenticated) { _showLoginDialog(); return; }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(items: [CheckoutItem(product: p, quantity: _quantity)]),
                            ),
                          );
                        },
                      ),
                    ),
                    // ... favorite button code ...
                  ],
                ),
              ),
            )
          : null,
    );
  }
}