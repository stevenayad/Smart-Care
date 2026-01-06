class Item {
  String? productId;
  String? mainImageUrl;
  List<dynamic>? images;
  String? nameEn;
  String? companyName;
  String? description;
  int? averageRating;
  int? totalRatings;
  double? price;
  bool? isAvailable;
  String? activeIngredients;
  String? tags;
  double? discountPercentage;

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: json['productId'] as String?,
    mainImageUrl: json['mainImageUrl'] as String?,
    images: json['images'] as List<dynamic>?,
    nameEn: json['nameEn'] as String?,
    companyName: json['companyName'] as String?,
    description: json['description'] as String?,
    averageRating: json['averageRating'] as int?,
    totalRatings: json['totalRatings'] as int?,
    price: (json['price'] as num?)?.toDouble(),
    isAvailable: json['isAvailable'] as bool?,
    activeIngredients: json['activeIngredients'] as String?,
    tags: json['tags'] as String?,
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
    'tags': tags,
    'discountPercentage': discountPercentage,
  };
}
