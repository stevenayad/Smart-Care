import 'product.dart';

class CreateOrderItem {
  String? id;
  String? orderId;
  String? invetoryId;
  int? quantity;
  double? unitPrice;
  double? subTotal;
  Product? product;

  CreateOrderItem({
    this.id,
    this.orderId,
    this.invetoryId,
    this.quantity,
    this.unitPrice,
    this.subTotal,
    this.product,
  });

  factory CreateOrderItem.fromJson(Map<String, dynamic> json) =>
      CreateOrderItem(
        id: json['id'] as String?,
        orderId: json['orderId'] as String?,
        invetoryId: json['invetoryId'] as String?,
        quantity: json['quantity'] as int?,
        unitPrice: (json['unitPrice'] as num?)?.toDouble(),
        subTotal: (json['subTotal'] as num?)?.toDouble(),
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'orderId': orderId,
    'invetoryId': invetoryId,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'subTotal': subTotal,
    'product': product?.toJson(),
  };
}
