import 'product.dart';

class Item {
  bool? isReadyForPickup;
  String? id;
  String? orderId;
  String? invetoryId;
  int? quantity;
  double? unitPrice;
  double? subTotal;
  Product? product;

  Item({
    this.isReadyForPickup,
    this.id,
    this.orderId,
    this.invetoryId,
    this.quantity,
    this.unitPrice,
    this.subTotal,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    isReadyForPickup: json['isReadyForPickup'] as bool?,
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
    'isReadyForPickup': isReadyForPickup,
    'id': id,
    'orderId': orderId,
    'invetoryId': invetoryId,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'subTotal': subTotal,
    'product': product?.toJson(),
  };
}
