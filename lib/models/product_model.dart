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
  });

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
