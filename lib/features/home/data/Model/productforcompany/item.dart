class ProductItemModel {
  String? productId;
  String? mainImageUrl;
  List<dynamic>? images;
  String? nameEn;
  String? companyName;
  String? description;
  double? averageRating;
  int? totalRatings;
  double? price;
  bool? isAvailable;
  String? activeIngredients;
  DateTime? expirationDate;
  double? discountPercentage;

  ProductItemModel({
    this.productId,
    this.mainImageUrl,
    this.images,
    this.nameEn,
    this.companyName,
    this.description,
    this.averageRating,
    this.totalRatings,
    this.price,
    this.isAvailable,
    this.activeIngredients,
    this.expirationDate,
    this.discountPercentage,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) =>
      ProductItemModel(
        productId: json['productId'] as String?,
        mainImageUrl: json['mainImageUrl'] as String?,
        images: json['images'] as List<dynamic>?,
        nameEn: json['nameEn'] as String?,
        companyName: json['companyName'] as String?,
        description: json['description'] as String?,
        averageRating: (json['averageRating'] as num?)?.toDouble(),
        totalRatings: json['totalRatings'] as int?,
        price: (json['price'] as num?)?.toDouble(),
        isAvailable: json['isAvailable'] as bool?,
        activeIngredients: json['activeIngredients'] as String?,
        expirationDate: json['expirationDate'] == null
            ? null
            : DateTime.parse(json['expirationDate'] as String),
        discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'mainImageUrl': mainImageUrl,
    'images': images,
    'nameEn': nameEn,
    'companyName': companyName,
    'description': description,
    'averageRating': averageRating,
    'totalRatings': totalRatings,
    'price': price,
    'isAvailable': isAvailable,
    'activeIngredients': activeIngredients,
    'expirationDate': expirationDate?.toIso8601String(),
    'discountPercentage': discountPercentage,
  };
}
