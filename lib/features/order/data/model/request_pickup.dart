class RequestPickup {
  String? cartId;
  String? storeId;

  RequestPickup({this.cartId, this.storeId});

  factory RequestPickup.fromJson(Map<String, dynamic> json) => RequestPickup(
    cartId: json['cartId'] as String?,
    storeId: json['storeId'] as String?,
  );

  Map<String, dynamic> toJson() => {'cartId': cartId, 'storeId': storeId};
}
