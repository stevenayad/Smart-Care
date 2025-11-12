class Data {
  String? productId;
  String? mainImageUrl;
  List<dynamic>? images;
  String? nameEn;
  String? companyName;
  String? description;
  int? averageRating;
  int? totalRatings;
  int? price;
  bool? isAvailable;
  String? activeIngredients;
  dynamic expirationDate;
  double? discountPercentage;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json['productId'] as String?,
    mainImageUrl: json['mainImageUrl'] as String?,
    images: json['images'] as List<dynamic>?,
    nameEn: json['nameEn'] as String?,
    companyName: json['companyName'] as String?,
    description: json['description'] as String?,
    averageRating: (json['averageRating'] as num?)?.toInt(),
    totalRatings: (json['totalRatings'] as num?)?.toInt(),
    price: (json['price'] as num?)?.toInt(),
    isAvailable: json['isAvailable'] as bool?,
    activeIngredients: json['activeIngredients'] as String?,
    expirationDate: json['expirationDate'],
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
    'expirationDate': expirationDate,
    'discountPercentage': discountPercentage,
  };
}
