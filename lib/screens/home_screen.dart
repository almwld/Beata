/// الصفحة الرئيسية
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ... existing code ...

  // بيانات وهمية للسلایدر
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

  // ... rest of the code with fixed Arabic text ...
}