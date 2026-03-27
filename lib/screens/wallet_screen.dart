import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'wallet/deposit_screen.dart';
import 'wallet/withdraw_screen.dart';
import 'wallet/transfer_screen.dart';
import 'wallet/transactions_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _services = [
    {'name': 'إيداع', 'icon': Icons.add_card, 'color': Colors.orange, 'screen': const DepositScreen()},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'screen': const WithdrawScreen()},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'screen': const TransferScreen()},
    {'name': 'عمليات', 'icon': Icons.history, 'color': Colors.teal, 'screen': const TransactionsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('المحفظة'),
        backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الرصيد الحالي', style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('0 ريال', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('آخر تحديث: اليوم', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('الخدمات المالية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => service['screen']));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (service['color'] as Color).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(service['icon'] as IconData, size: 32, color: service['color']),
                        ),
                        const SizedBox(height: 12),
                        Text(service['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
