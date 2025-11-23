class RequestAddItemModel {
  String? cartId;
  String? productId;
  int? quantity;

  RequestAddItemModel({this.cartId, this.productId, this.quantity});

  factory RequestAddItemModel.fromJson(Map<String, dynamic> json) {
    return RequestAddItemModel(
      cartId: json['cartId'] as String?,
      productId: json['productId'] as String?,
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'productId': productId,
    'quantity': quantity,
  };
}
