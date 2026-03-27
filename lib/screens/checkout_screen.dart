import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/simple_app_bar.dart';
import '../models/product_model.dart';
import 'login_screen.dart';

class CheckoutItem {
  final ProductModel product;
  final int quantity;
  CheckoutItem({required this.product, required this.quantity});
  double get totalPrice => product.price * quantity;
}

class CheckoutScreen extends StatefulWidget {
  final List<CheckoutItem> items;
  const CheckoutScreen({super.key, required this.items});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isProcessing = false;

  double get _subtotal => widget.items.fold(0, (sum, i) => sum + i.totalPrice);
  double get _shipping => 2000;
  double get _total => _subtotal + _shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'إتمام الشراء'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ...widget.items.map((i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(child: Text(i.product.title)),
                          Text('${i.totalPrice.toStringAsFixed(0)} ر.ي'),
                        ],
                      ),
                    )),
                    const Divider(),
                    _buildPriceRow('المجموع', _subtotal),
                    _buildPriceRow('الشحن', _shipping),
                    const Divider(),
                    _buildPriceRow('الإجمالي', _total, isTotal: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'تأكيد الدفع',
              onPressed: () {
                setState(() => _isProcessing = true);
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() => _isProcessing = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إتمام الطلب بنجاح')),
                  );
                });
              },
              isLoading: _isProcessing,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isTotal ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text('${amount.toStringAsFixed(0)} ر.ي', style: isTotal ? const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}
