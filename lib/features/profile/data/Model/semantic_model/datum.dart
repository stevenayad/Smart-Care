class SemanticDatum {
  String? productId;
  dynamic mainImageUrl;
  List<dynamic>? images;
  String? nameEn;
  dynamic companyName;
  String? description;
  double? averageRating;
  int? totalRatings;
  double? price;
  bool? isAvailable;
  String? activeIngredients;
  String? tags;
  int? discountPercentage;

  SemanticDatum({
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
    this.tags,
    this.discountPercentage,
  });

  factory SemanticDatum.fromJson(Map<String, dynamic> json) => SemanticDatum(
    productId: json['productId'] as String?,
    mainImageUrl: json['mainImageUrl'] as dynamic,
    images: json['images'] as List<dynamic>?,
    nameEn: json['nameEn'] as String?,
    companyName: json['companyName'] as dynamic,
    description: json['description'] as String?,
    averageRating: (json['averageRating'] as num?)?.toDouble(),
    totalRatings: json['totalRatings'] as int?,
    price: (json['price'] as num?)?.toDouble(),
    isAvailable: json['isAvailable'] as bool?,
    activeIngredients: json['activeIngredients'] as String?,
    tags: json['tags'] as String?,
    discountPercentage: json['discountPercentage'] as int?,
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
    'tags': tags,
    'discountPercentage': discountPercentage,
  };
}
