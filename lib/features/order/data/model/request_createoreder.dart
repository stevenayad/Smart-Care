class RequestCreateoreder {
  String? cartId;
  String? deliveryAddressId;

  RequestCreateoreder({this.cartId, this.deliveryAddressId});

  factory RequestCreateoreder.fromJson(Map<String, dynamic> json) {
    return RequestCreateoreder(
      cartId: json['cartId'] as String?,
      deliveryAddressId: json['deliveryAddressId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'deliveryAddressId': deliveryAddressId,
  };
}
