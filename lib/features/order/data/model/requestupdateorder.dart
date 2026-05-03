class RequestUpdateOrder {
  String? orderId;
  String? cartId;
  int? updatedOrderType;
  String? storeId;
  String? shippingAddressId;

  RequestUpdateOrder({
    this.orderId,
    this.cartId,
    this.updatedOrderType,
    this.storeId,
    this.shippingAddressId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderId != null) data['orderId'] = orderId;
    if (cartId != null) data['cartId'] = cartId;
    if (updatedOrderType != null) data['updatedOrderType'] = updatedOrderType;
    if (storeId != null) data['storeId'] = storeId;
    if (shippingAddressId != null) data['shippingAddressId'] = shippingAddressId;
    return data;
  }
}
