import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String? category;
  final String? searchQuery;
  const ProductsScreen({super.key, this.category, this.searchQuery});
  @override State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _error;
  String _selectedSort = 'الأحدث';
  final List<String> _sortOptions = ['الأحدث', 'السعر: الأقل', 'السعر: الأعلى', 'الأعلى تقييماً'];
  RangeValues _priceRange = const RangeValues(0, 1000000);
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      _products = await SupabaseService.getProducts(
        category: widget.category,
        searchQuery: widget.searchQuery,
        minPrice: _priceRange.start,
        maxPrice: _priceRange.end,
      );
      _sortProducts(_selectedSort);
    } catch (e) {
      _error = 'حدث خطأ في تحميل المنتجات';
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _sortProducts(String option) {
    setState(() {
      _selectedSort = option;
      switch (option) {
        case 'السعر: الأقل': _products.sort((a, b) => a.price.compareTo(b.price)); break;
        case 'السعر: الأعلى': _products.sort((a, b) => b.price.compareTo(a.price)); break;
        case 'الأعلى تقييماً': _products.sort((a, b) => b.rating.compareTo(a.rating)); break;
        default: _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(title: widget.searchQuery != null ? 'نتائج البحث' : (widget.category ?? 'المنتجات')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                      const SizedBox(height: 16),
                      Text(_error!),
                      const SizedBox(height: 16),
                      CustomButton(text: 'إعادة المحاولة', onPressed: _loadProducts),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // شريط الفلترة والترتيب
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_products.length} منتج', style: TextStyle(color: Colors.grey[600])),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.filter_list, color: AppTheme.goldColor),
                                onPressed: () => setState(() => _showFilters = !_showFilters),
                              ),
                              DropdownButton<String>(
                                value: _selectedSort,
                                items: _sortOptions.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                                onChanged: (v) { if (v != null) _sortProducts(v); },
                                underline: Container(),
                                icon: const Icon(Icons.sort),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // لوحة الفلاتر (إذا ظهرت)
                    if (_showFilters)
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        child: Column(
                          children: [
                            const Text('نطاق السعر', style: TextStyle(fontWeight: FontWeight.bold)),
                            RangeSlider(
                              values: _priceRange,
                              min: 0,
                              max: 1000000,
                              divisions: 20,
                              labels: RangeLabels('${_priceRange.start.round()} ر.ي', '${_priceRange.end.round()} ر.ي'),
                              onChanged: (v) => setState(() => _priceRange = v),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: CustomButton(text: 'تطبيق', onPressed: _loadProducts)),
                                const SizedBox(width: 12),
                                Expanded(child: CustomButton(text: 'إلغاء', onPressed: () => setState(() => _showFilters = false), isOutlined: true)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: _products.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.inventory_2, size: 80, color: Colors.grey[400]),
                                  const SizedBox(height: 16),
                                  const Text('لا توجد منتجات'),
                                ],
                              ),
                            )
                          : GridView.builder(
                              // ... grid code ...
                              itemBuilder: (_, i) {
                                final p = _products[i];
                                return GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
                                  child: Container(
                                    // ... container code ...
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Stack(
                                            children: [
                                              // ... image code ...
                                              if (!p.inStock)
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                                                    child: const Text('غير متوفر', style: TextStyle(color: Colors.white, fontSize: 10)),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        // ... rest of the card code ...
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}