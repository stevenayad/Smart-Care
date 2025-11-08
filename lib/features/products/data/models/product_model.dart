import 'package:equatable/equatable.dart';

class ProductImageModel extends Equatable {
  final String id;
  final String url;
  final bool isPrimary;

  const ProductImageModel({
    required this.id,
    required this.url,
    required this.isPrimary,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      isPrimary: json['isPrimary'] == true,
    );
  }

  @override
  List<Object?> get props => [id, url, isPrimary];
}

class ProductModel extends Equatable {
  final String productId;
  final List<ProductImageModel> images;
  final String nameEn;
  final String description;
  final double averageRating;
  final int totalRatings;
  final double price;
  final bool isAvailable;
  final String activeIngredients;
  final DateTime? expirationDate;
  final double discountPercentage;

  const ProductModel({
    required this.productId,
    required this.images,
    required this.nameEn,
    required this.description,
    required this.averageRating,
    required this.totalRatings,
    required this.price,
    required this.isAvailable,
    required this.activeIngredients,
    required this.expirationDate,
    required this.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var imagesJson = <ProductImageModel>[];
    if (json['images'] is List) {
      imagesJson = (json['images'] as List)
          .map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    DateTime? exp;
    if (json['expirationDate'] != null) {
      try {
        exp = DateTime.parse(json['expirationDate']);
      } catch (_) {
        exp = null;
      }
    }
    return ProductModel(
      productId: json['productId']?.toString() ?? '',
      images: imagesJson,
      nameEn: json['nameEn']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      averageRating: (json['averageRating']?.toDouble() ?? 0.0),
      totalRatings: (json['totalRatings']?.toInt() ?? 0),
      price: (json['price']?.toDouble() ?? 0.0),
      isAvailable: json['isAvailable'] == true,
      activeIngredients: json['activeIngredients']?.toString() ?? '',
      expirationDate: exp,
      discountPercentage: (json['discountPercentage']?.toDouble() ?? 0.0),
    );
  }

  String get primaryImageUrl => images.isNotEmpty ? images.first.url : '';

  @override
  List<Object?> get props => [productId];
}
