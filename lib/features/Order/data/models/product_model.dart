class ProductModel {
  final String? productId;
  final String? nameEn;
  final String? description;
  final double? price;
  final double? discountPercentage;
  final String? imageUrl;

  ProductModel({
    this.productId,
    this.nameEn,
    this.description,
    this.price,
    this.discountPercentage,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as String?,
      nameEn: json['nameEn'] as String?,
      description: json['description'] as String?,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      discountPercentage: json['discountPercentage'] != null ? (json['discountPercentage'] as num).toDouble() : null,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'nameEn': nameEn,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'imageUrl': imageUrl,
    };
  }
}
