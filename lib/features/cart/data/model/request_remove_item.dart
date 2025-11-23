class RequestRemoveItem {
  String? cartItemId;
  String? cartId;

  RequestRemoveItem({this.cartItemId, this.cartId});

  factory RequestRemoveItem.fromJson(Map<String, dynamic> json) {
    return RequestRemoveItem(
      cartItemId: json['cartItemId'] as String?,
      cartId: json['cartId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'cartItemId': cartItemId, 'cartId': cartId};
}
