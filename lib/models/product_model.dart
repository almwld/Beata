import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? oldPrice;
  final String currency;
  final List<String> images;
  final String category;
  final String? subCategory;
  final String sellerId;
  final String sellerName;
  final double sellerRating;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;
  final String? city;
  final bool isAuction;
  final DateTime? auctionEndTime;
  final double? currentBid;
  final int? bidCount;
  final bool hasDiscount;
  final int discountPercent;
  final String status; // active, sold, expired

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.oldPrice,
    this.currency = 'YER',
    required this.images,
    required this.category,
    this.subCategory,
    required this.sellerId,
    required this.sellerName,
    this.sellerRating = 0.0,
    this.inStock = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.createdAt,
    this.city,
    this.isAuction = false,
    this.auctionEndTime,
    this.currentBid,
    this.bidCount,
    this.hasDiscount = false,
    this.discountPercent = 0,
    this.status = 'active',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price'] != null ? (json['old_price'] as num).toDouble() : null,
      currency: json['currency'] ?? 'YER',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      subCategory: json['sub_category'],
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerRating: (json['seller_rating'] ?? 0).toDouble(),
      inStock: json['in_stock'] ?? true,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      city: json['city'],
      isAuction: json['is_auction'] ?? false,
      auctionEndTime: json['auction_end_time'] != null ? DateTime.parse(json['auction_end_time']) : null,
      currentBid: json['current_bid']?.toDouble(),
      bidCount: json['bid_count'],
      hasDiscount: json['has_discount'] ?? false,
      discountPercent: json['discount_percent'] ?? 0,
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'currency': currency,
      'images': images,
      'category': category,
      'sub_category': subCategory,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_rating': sellerRating,
      'in_stock': inStock,
      'rating': rating,
      'review_count': reviewCount,
      'created_at': createdAt.toIso8601String(),
      'city': city,
      'is_auction': isAuction,
      'auction_end_time': auctionEndTime?.toIso8601String(),
      'current_bid': currentBid,
      'bid_count': bidCount,
      'has_discount': hasDiscount,
      'discount_percent': discountPercent,
      'status': status,
    };
  }

  String get formattedPrice {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    }
    return price.toStringAsFixed(0);
  }

  String get currencySymbol {
    switch (currency) {
      case 'YER':
        return 'ر.ي';
      case 'SAR':
        return 'ر.س';
      case 'USD':
        return '\$';
      default:
        return currency;
    }
  }
}
