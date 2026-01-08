class BestSellerItem {
  String? productId;
  String? mainImageUrl;
  List<String>? images;
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
  String? tags;

  BestSellerItem({
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
    this.tags,
  });

  factory BestSellerItem.fromJson(Map<String, dynamic> json) => BestSellerItem(
    productId: json['productId'],
    mainImageUrl: json['mainImageUrl'],
    images: json['images'] == null
        ? null
        : List<String>.from(json['images'].map((x) => x.toString())),
    nameEn: json['nameEn'],
    companyName: json['companyName'],
    description: json['description'],
    averageRating: (json['averageRating'] as num?)?.toInt(),
    totalRatings: (json['totalRatings'] as num?)?.toInt(),
    price: (json['price'] as num?)?.toInt(),
    isAvailable: json['isAvailable'],
    activeIngredients: json['activeIngredients'].toString(),
    expirationDate: json['expirationDate'],
    tags: json['tags']?.toString(),
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
    'tags': tags,
  };
}
