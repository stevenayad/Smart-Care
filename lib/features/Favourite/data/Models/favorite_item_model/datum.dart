class FavDatum {
  String? productId;
  String? productNameAr;
  String? productNameEn;
  String? description;
  int? averageRating;
  int? totalRatings;
  dynamic mainImageUrl;
  int? price;
  bool? isAvailable;

  FavDatum({
    this.productId,
    this.productNameAr,
    this.productNameEn,
    this.description,
    this.averageRating,
    this.totalRatings,
    this.mainImageUrl,
    this.price,
    this.isAvailable,
  });

  factory FavDatum.fromJson(Map<String, dynamic> json) => FavDatum(
    productId: json['productId'] as String?,
    productNameAr: json['productNameAr'] as String?,
    productNameEn: json['productNameEn'] as String?,
    description: json['description'] as String?,
    averageRating: (json['averageRating'] != null)
        ? (json['averageRating'] as num).toInt()
        : null,
    totalRatings: (json['totalRatings'] != null)
        ? (json['totalRatings'] as num).toInt()
        : null,
    price: (json['price'] != null) ? (json['price'] as num).toInt() : null,

    mainImageUrl: json['mainImageUrl'] as dynamic,

    isAvailable: json['isAvailable'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'productNameAr': productNameAr,
    'productNameEn': productNameEn,
    'description': description,
    'averageRating': averageRating,
    'totalRatings': totalRatings,
    'mainImageUrl': mainImageUrl,
    'price': price,
    'isAvailable': isAvailable,
  };
}
