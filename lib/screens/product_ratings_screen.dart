import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'add_rating_screen.dart';
import 'login_screen.dart';

class ProductRatingsScreen extends StatefulWidget {
  final String productId;
  final String productTitle;
  const ProductRatingsScreen({super.key, required this.productId, required this.productTitle});

  @override
  State<ProductRatingsScreen> createState() => _ProductRatingsScreenState();
}

class _ProductRatingsScreenState extends State<ProductRatingsScreen> {
  List<Map<String, dynamic>> _ratings = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    _ratings = [
      {'userName': 'أحمد علي', 'rating': 5, 'comment': 'منتج ممتاز', 'date': '2024-01-15'},
    ];
    setState(() => _isLoading = false);
  }

  void _navigateToAddRating() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddRatingScreen(
          productId: widget.productId,
          productTitle: widget.productTitle,
          onRatingAdded: _loadData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقييمات ${widget.productTitle}'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _navigateToAddRating),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _ratings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_border, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('لا توجد تقييمات بعد', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      const Text('كن أول من يقيم هذا المنتج'),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _navigateToAddRating,
                        icon: const Icon(Icons.add),
                        label: const Text('أضف تقييمك'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _ratings.length,
                  itemBuilder: (ctx, i) {
                    final r = _ratings[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(child: Text(r['userName'][0])),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(r['userName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: List.generate(5, (i) => Icon(
                                          i < r['rating'] ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                          size: 14,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(r['date'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                              ],
                            ),
                            if (r['comment'].isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(r['comment']),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
