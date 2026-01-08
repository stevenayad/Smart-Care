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
    return {
      "orderId": orderId,
      "cartId": cartId,
      "updatedOrderType": updatedOrderType,
      "storeId": storeId, 
      "shippingAddressId": shippingAddressId,
    };
  }
}
