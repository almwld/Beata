import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/supabase_service.dart';
import '../widgets/ad_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/empty_state.dart';

class AllAdsScreen extends StatefulWidget {
  final String? category;
  final String? searchQuery;
  
  const AllAdsScreen({super.key, this.category, this.searchQuery});

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  List<ProductModel> _allAds = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  Future<void> _loadAds() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final products = await SupabaseService.getProducts(
        category: widget.category,
        searchQuery: widget.searchQuery,
      );
      setState(() {
        _allAds = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? (widget.searchQuery != null ? 'نتائج البحث' : 'جميع الإعلانات')),
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'جاري التحميل...')
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('حدث خطأ: $_error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadAds,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                )
              : _allAds.isEmpty
                  ? const EmptyState(
                      icon: Icons.inbox_outlined,
                      title: 'لا توجد إعلانات',
                      subtitle: 'لم يتم العثور على إعلانات',
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _allAds.length,
                      itemBuilder: (context, index) {
                        return AdCard(
                          product: _allAds[index],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/ad_detail',
                              arguments: _allAds[index],
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
