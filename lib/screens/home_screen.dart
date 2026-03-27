import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/ad_card.dart';
import '../widgets/loading_widget.dart';
import '../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;
  bool _isLoading = false;
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _auctionProducts = [];
  List<ProductModel> _newProducts = [];

  // بيانات السلايدر
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'إعلانات حصرية للتجار',
      'subtitle': 'انضم إلينا وقم بعرض منتجاتك',
      'color': const Color(0xFF6C63FF),
      'icon': Icons.store,
    },
    {
      'title': 'VIP عروض',
      'subtitle': 'خصومات حصرية تصل إلى 50%',
      'color': const Color(0xFFFF6B6B),
      'icon': Icons.local_offer,
    },
    {
      'title': 'عروض أفضل المطاعم',
      'subtitle': 'اكتشف أشهى الأطباق',
      'color': const Color(0xFF4ECDC4),
      'icon': Icons.restaurant,
    },
    {
      'title': 'مزادات السيارات والعقارات',
      'subtitle': 'فرص استثمارية فريدة',
      'color': const Color(0xFFFFE66D),
      'icon': Icons.gavel,
    },
    {
      'title': 'إعلانات المنصة',
      'subtitle': 'تابع أحدث الأخبار والتحديثات',
      'color': const Color(0xFF95E1D3),
      'icon': Icons.campaign,
    },
  ];

  // بيانات "مزيد من ما تريد"
  final List<Map<String, dynamic>> _quickCategories = [
    {'name': 'معلمات', 'icon': Icons.school, 'color': const Color(0xFF6C63FF)},
    {'name': 'عقارات', 'icon': Icons.apartment, 'color': const Color(0xFF4ECDC4)},
    {'name': 'سفر', 'icon': Icons.flight, 'color': const Color(0xFFFF6B6B)},
    {'name': 'شحن', 'icon': Icons.local_shipping, 'color': const Color(0xFFFFE66D)},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': const Color(0xFF95E1D3)},
  ];

  // بيانات العقارات والاستثمارات
  final List<Map<String, dynamic>> _realEstateCategories = [
    {'name': 'شقق الإيجار', 'icon': Icons.apartment, 'color': const Color(0xFF3498DB)},
    {'name': 'فلل البيع', 'icon': Icons.villa, 'color': const Color(0xFF2ECC71)},
    {'name': 'أراضي', 'icon': Icons.terrain, 'color': const Color(0xFFE67E22)},
    {'name': 'مكافآت', 'icon': Icons.card_giftcard, 'color': const Color(0xFF9B59B6)},
    {'name': 'محطات', 'icon': Icons.local_gas_station, 'color': const Color(0xFF1ABC9C)},
    {'name': 'مقاولات', 'icon': Icons.construction, 'color': const Color(0xFFE74C3C)},
    {'name': 'ديكور', 'icon': Icons.design_services, 'color': const Color(0xFF34495E)},
  ];

  // بيانات الإلكترونيات
  final List<Map<String, dynamic>> _techCategories = [
    {'name': 'هواتف ذكية', 'icon': Icons.smartphone, 'color': const Color(0xFF9B59B6)},
    {'name': 'لاب توب', 'icon': Icons.laptop, 'color': const Color(0xFF3498DB)},
    {'name': 'ستارلينك', 'icon': Icons.wifi, 'color': const Color(0xFF2ECC71)},
    {'name': 'كاميرات', 'icon': Icons.camera_alt, 'color': const Color(0xFFE74C3C)},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    _featuredProducts = _getDummyProducts();
    _auctionProducts = _getDummyAuctionProducts();
    _newProducts = _getDummyProducts().take(4).toList();
    setState(() => _isLoading = false);
  }

  List<ProductModel> _getDummyProducts() {
    return [
      ProductModel(
        id: '1',
        title: 'آيفون 15 برو ماكس 256GB',
        description: 'هاتف أيفون جديد بالكامل',
        price: 450000,
        oldPrice: 500000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'إلكترونيات',
        sellerId: 'seller1',
        sellerName: 'متجر التقنية',
        sellerRating: 4.8,
        rating: 4.8,
        reviewCount: 120,
        createdAt: DateTime.now(),
      ),
      ProductModel(
        id: '2',
        title: 'لاب توب Dell XPS 15',
        description: 'لاب توب احترافي',
        price: 380000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'إلكترونيات',
        sellerId: 'seller2',
        sellerName: 'الحاسوب المتقدم',
        sellerRating: 4.5,
        rating: 4.5,
        reviewCount: 85,
        createdAt: DateTime.now(),
      ),
    ];
  }

  List<ProductModel> _getDummyAuctionProducts() {
    return [
      ProductModel(
        id: 'a1',
        title: 'ساعة رولكس أصلية',
        description: 'ساعة فاخرة بحالة ممتازة',
        price: 2500000,
        currency: 'YER',
        images: ['https://via.placeholder.com/300x200'],
        category: 'ساعات',
        sellerId: 'seller6',
        sellerName: 'الساعات الفاخرة',
        sellerRating: 4.9,
        rating: 4.9,
        reviewCount: 50,
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: AppBar(title: const Text('الرئيسية'), backgroundColor: Colors.transparent, elevation: 0),
      body: _isLoading
          ? const LoadingWidget(message: 'جاري التحميل...')
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarousel(),
                  const SizedBox(height: 24),
                  _buildQuickCategories(),
                  const SizedBox(height: 24),
                  _buildAuctionSection(),
                  const SizedBox(height: 24),
                  _buildRealEstateSection(),
                  const SizedBox(height: 24),
                  _buildTechSection(),
                  const SizedBox(height: 24),
                  _buildFeaturedProducts(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) => setState(() => _currentSlide = index),
          ),
          items: _slides.map((slide) {
            return Builder(
              builder: (context) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [slide['color'], slide['color'].withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Icon(slide['icon'], size: 150, color: Colors.white.withOpacity(0.1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(slide['title'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 8),
                          Text(slide['subtitle'], style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _slides.asMap().entries.map((entry) {
            return Container(
              width: _currentSlide == entry.key ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentSlide == entry.key ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('مزيد من ما تريد', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('المزيد', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _quickCategories.length,
            itemBuilder: (context, index) {
              final cat = _quickCategories[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: (cat['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(cat['icon'] as IconData, color: cat['color'], size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(cat['name'], style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAuctionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('مزاد الجانبي الأسبوعي', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('المزيد', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _auctionProducts.length,
          itemBuilder: (context, index) {
            return AdCard(product: _auctionProducts[index], onTap: () {});
          },
        ),
      ],
    );
  }

  Widget _buildRealEstateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('العقارات والاستثمارات', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('المزيد', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _realEstateCategories.length,
            itemBuilder: (context, index) {
              final cat = _realEstateCategories[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (cat['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat['icon'] as IconData, color: cat['color'], size: 32),
                      const SizedBox(height: 8),
                      Text(cat['name'], style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTechSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('عالم الإلكترونيات والتقنية', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('المزيد', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _techCategories.length,
            itemBuilder: (context, index) {
              final cat = _techCategories[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (cat['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat['icon'] as IconData, color: cat['color'], size: 32),
                      const SizedBox(height: 8),
                      Text(cat['name'], style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('منتجات مميزة', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('المزيد', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _newProducts.length,
          itemBuilder: (context, index) {
            return AdCard(product: _newProducts[index], onTap: () {});
          },
        ),
      ],
    );
  }
}
