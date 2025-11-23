class RequestUpdateItemModel {
  String? cartId;
  String? cartItemId;
  String? productId;
  int? newQuantity;

  RequestUpdateItemModel({
    this.cartId,
    this.cartItemId,
    this.productId,
    this.newQuantity,
  });

  factory RequestUpdateItemModel.fromJson(Map<String, dynamic> json) {
    return RequestUpdateItemModel(
      cartId: json['cartId'] as String?,
      cartItemId: json['cartItemId'] as String?,
      productId: json['productId'] as String?,
      newQuantity: json['newQuantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'cartItemId': cartItemId,
    'productId': productId,
    'newQuantity': newQuantity,
  };
}
