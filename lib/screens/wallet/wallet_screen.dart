import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

/// شاشة المحفظة الرئيسية
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCardIndex = 0;
  
  // بيانات وهمية للرصيد
  final List<Map<String, dynamic>> _balances = [
    {'currency': 'YER', 'amount': 125000.0, 'symbol': 'ر.ي', 'name': 'ريال يمني'},
    {'currency': 'SAR', 'amount': 2500.0, 'symbol': 'ر.س', 'name': 'ريال سعودي'},
    {'currency': 'USD', 'amount': 500.0, 'symbol': '\$', 'name': 'دولار أمريكي'},
  ];

  // خدمات المحفظة (محافظ إلكترونية وخدمات مالية يمنية)
  final List<Map<String, dynamic>> _services = [
    // المحافظ الإلكترونية اليمنية
    {'name': 'فلكسي', 'icon': Icons.flash_on, 'route': '/jib', 'color': 0xFFD4AF37},
    {'name': 'جيب', 'icon': Icons.account_balance_wallet, 'route': '/geeb', 'color': 0xFF2ECC71},
    {'name': 'جوالي', 'icon': Icons.phone_android, 'route': '/jawali', 'color': 0xFF3498DB},
    {'name': 'ون كاش', 'icon': Icons.money, 'route': '/onecash', 'color': 0xFFE74C3C},
    {'name': 'أيزلي', 'icon': Icons.water_drop, 'route': '/azli', 'color': 0xFF1ABC9C},
    {'name': 'كاك بنكي', 'icon': Icons.account_balance, 'route': '/kakbanki', 'color': 0xFF9B59B6},
    {'name': 'محفظتي', 'icon': Icons.wallet, 'route': '/mywallet', 'color': 0xFFF39C12},
    {'name': 'بنكي لايت', 'icon': Icons.lightbulb, 'route': '/bankilite', 'color': 0xFF16A085},
    {'name': 'كاش', 'icon': Icons.attach_money, 'route': '/cash', 'color': 0xFFE67E22},
    {'name': 'يمن والات', 'icon': Icons.flag, 'route': '/yemenwallet', 'color': 0xFF27AE60},
    
    // الخدمات الأساسية
    {'name': 'إيداع', 'icon': Icons.arrow_downward, 'route': '/deposit', 'color': 0xFF2ECC71},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'route': '/transfer', 'color': 0xFF3498DB},
    {'name': 'سحب', 'icon': Icons.arrow_upward, 'route': '/withdraw', 'color': 0xFFE74C3C},
    {'name': 'فواتير', 'icon': Icons.receipt_long, 'route': '/payments', 'color': 0xFFF39C12},
    {'name': 'العمليات', 'icon': Icons.history, 'route': '/transactions', 'color': 0xFF95A5A6},
    
    // خدمات أخرى
    {'name': 'شبكة تحويل', 'icon': Icons.network_cell, 'route': '/transfer_network', 'color': 0xFF1ABC9C},
    {'name': 'ترفيه', 'icon': Icons.movie, 'route': '/entertainment', 'color': 0xFF9B59B6},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'route': '/games', 'color': 0xFFE74C3C},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'route': '/apps', 'color': 0xFF3498DB},
    {'name': 'بطاقات نت', 'icon': Icons.card_giftcard, 'route': '/gift_cards', 'color': 0xFFF1C40F},
    {'name': 'أمازون', 'icon': Icons.shopping_cart, 'route': '/amazon_gift_cards', 'color': 0xFFF39C12},
    {'name': 'بنوك ومحافظ', 'icon': Icons.account_balance, 'route': '/banks_wallets', 'color': 0xFF2ECC71},
    {'name': 'تحويلات', 'icon': Icons.send, 'route': '/money_transfers', 'color': 0xFF3498DB},
    {'name': 'مدفوعات حكومية', 'icon': Icons.account_balance_wallet, 'route': '/government_payments', 'color': 0xFFE67E22},
    {'name': 'سحب نقدي', 'icon': Icons.money, 'route': '/cash_withdrawal', 'color': 0xFF27AE60},
    {'name': 'تعليم عالي', 'icon': Icons.school, 'route': '/universities', 'color': 0xFF9B59B6},
    {'name': 'شحن وسداد', 'icon': Icons.phone_android, 'route': '/recharge_payment', 'color': 0xFFE74C3C},
    {'name': 'شحن رصيد', 'icon': Icons.signal_cellular_alt, 'route': '/recharge_credit', 'color': 0xFFF1C40F},
    {'name': 'سداد باقات', 'icon': Icons.wifi, 'route': '/pay_bundles', 'color': 0xFF1ABC9C},
    {'name': 'إنترنت وهاتف', 'icon': Icons.router, 'route': '/internet_landline', 'color': 0xFF3498DB},
    {'name': 'استلام حوالة', 'icon': Icons.download, 'route': '/receive_transfer', 'color': 0xFF2ECC71},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const CustomAppBar(title: 'المحفظة'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildBalanceCards(),
            const SizedBox(height: 24),
            _buildCardIndicators(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'المحافظ الإلكترونية',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildEwalletsGrid(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'الخدمات المالية',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFinancialServicesGrid(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCards() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: _balances.length,
        onPageChanged: (index) {
          setState(() {
            _currentCardIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final balance = _balances[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.goldColor.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            balance['name'],
                            style: const TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 16,
                              color: AppTheme.darkText,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              balance['currency'],
                              style: const TextStyle(
                                fontFamily: 'Changa',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        'الرصيد الحالي',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 14,
                          color: AppTheme.darkText.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${balance['amount'].toStringAsFixed(0)} ${balance['symbol']}',
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkText,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: AppTheme.darkText,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Flex Yemen Wallet',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 12,
                              color: AppTheme.darkText.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().scale(delay: const Duration(milliseconds: 200));
        },
      ),
    );
  }

  Widget _buildCardIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _balances.asMap().entries.map((entry) {
        return Container(
          width: _currentCardIndex == entry.key ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentCardIndex == entry.key
                ? AppTheme.goldColor
                : Colors.grey.withOpacity(0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEwalletsGrid() {
    // المحافظ الإلكترونية فقط
    final ewallets = _services.where((s) => 
      s['name'] == 'فلكسي' || 
      s['name'] == 'جيب' || 
      s['name'] == 'جوالي' || 
      s['name'] == 'ون كاش' || 
      s['name'] == 'أيزلي' || 
      s['name'] == 'كاك بنكي' || 
      s['name'] == 'محفظتي' || 
      s['name'] == 'بنكي لايت' || 
      s['name'] == 'كاش' || 
      s['name'] == 'يمن والات'
    ).toList();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: ewallets.length,
        itemBuilder: (context, index) {
          final service = ewallets[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('جاري تحويلك إلى ${service['name']}', style: const TextStyle(fontFamily: 'Changa')),
                  backgroundColor: AppTheme.goldColor,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(service['color']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      service['icon'],
                      color: Color(service['color']),
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['name'],
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 11,
                      color: AppTheme.getTextColor(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(
            delay: Duration(milliseconds: index * 30),
          ).scale(
            delay: Duration(milliseconds: index * 30),
          );
        },
      ),
    );
  }

  Widget _buildFinancialServicesGrid() {
    // الخدمات المالية فقط (ما عدا المحافظ)
    final services = _services.where((s) => 
      s['name'] != 'فلكسي' && 
      s['name'] != 'جيب' && 
      s['name'] != 'جوالي' && 
      s['name'] != 'ون كاش' && 
      s['name'] != 'أيزلي' && 
      s['name'] != 'كاك بنكي' && 
      s['name'] != 'محفظتي' && 
      s['name'] != 'بنكي لايت' && 
      s['name'] != 'كاش' && 
      s['name'] != 'يمن والات'
    ).toList();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, service['route']);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(service['color']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      service['icon'],
                      color: Color(service['color']),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service['name'],
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 12,
                      color: AppTheme.getTextColor(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(
            delay: Duration(milliseconds: index * 30),
          ).scale(
            delay: Duration(milliseconds: index * 30),
          );
        },
      ),
    );
  }
}