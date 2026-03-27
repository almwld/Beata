import '../models/product_model.dart';

class DummyData {
  static List<ProductModel> getProducts() {
    return [
      ProductModel(
        id: '1',
        title: 'آيفون 15 برو ماكس',
        description: 'هاتف أيفون جديد بالكامل',
        price: 450000,
        oldPrice: 500000,
        currency: 'YER',
        images: ['https://picsum.photos/id/1/300/300'],
        category: 'إلكترونيات',
        subCategory: 'هواتف',
        sellerId: 'seller1',
        sellerName: 'متجر التقنية',
        inStock: true,
        rating: 4.8,
        reviewCount: 120,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
