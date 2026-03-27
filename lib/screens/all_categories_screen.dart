import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'إلكترونيات', 'icon': Icons.devices, 'color': Colors.blue, 'count': 1234},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.red, 'count': 567},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green, 'count': 345},
    {'name': 'أثاث', 'icon': Icons.chair, 'color': Colors.brown, 'count': 234},
    {'name': 'ملابس', 'icon': Icons.checkroom, 'color': Colors.pink, 'count': 456},
    {'name': 'مطاعم', 'icon': Icons.restaurant, 'color': Colors.orange, 'count': 789},
    {'name': 'خدمات', 'icon': Icons.build, 'color': Colors.purple, 'count': 123},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.teal, 'count': 89},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'جميع الفئات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: (cat['color'] as Color).withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'] as IconData, color: cat['color']),
                  ),
                  const SizedBox(height: 8),
                  Text(cat['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${cat['count']} منتج', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
