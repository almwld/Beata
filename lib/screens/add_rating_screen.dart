import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class AddRatingScreen extends StatefulWidget {
  final String productId;
  final String productTitle;
  final VoidCallback onRatingAdded;
  const AddRatingScreen({
    super.key,
    required this.productId,
    required this.productTitle,
    required this.onRatingAdded,
  });

  @override
  State<AddRatingScreen> createState() => _AddRatingScreenState();
}

class _AddRatingScreenState extends State<AddRatingScreen> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أضف تقييمك')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('قيم هذا المنتج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text(widget.productTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () => setState(() => _rating = index + 1),
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 40,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _rating == 0 ? 'اختر التقييم' : 'تقييم: $_rating من 5',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'اكتب تعليقك (اختياري)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'شارك تجربتك مع هذا المنتج...',
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'إرسال التقييم',
              onPressed: _rating == 0 ? null : () {
                setState(() => _isSubmitting = true);
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() => _isSubmitting = false);
                  widget.onRatingAdded();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إضافة تقييمك بنجاح!')),
                  );
                });
              },
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}
