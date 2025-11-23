class Product {
  String? productId;
  String? nameEn;
  String? description;
  double? price;
  double? discountPercentage;
  String? imageUrl;

  Product({
    this.productId,
    this.nameEn,
    this.description,
    this.price,
    this.discountPercentage,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json['productId'] as String?,
    nameEn: json['nameEn'] as String?,
    description: json['description'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
    imageUrl: json['imageUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'nameEn': nameEn,
    'description': description,
    'price': price,
    'discountPercentage': discountPercentage,
    'imageUrl': imageUrl,
  };
}
