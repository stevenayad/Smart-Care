import 'product_model.dart';

class OrderItemModel {
  final String id;
  final String? orderId;
  final String? invetoryId;
  final int? quantity;
  final double? unitPrice;
  final double? subTotal;
  final ProductModel? product;

  OrderItemModel({
    required this.id,
    this.orderId,
    this.invetoryId,
    this.quantity,
    this.unitPrice,
    this.subTotal,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      orderId: json['orderId'] as String?,
      invetoryId: json['invetoryId'] as String?,
      quantity: json['quantity'] is int
          ? json['quantity'] as int
          : (json['quantity'] != null
                ? int.tryParse(json['quantity'].toString())
                : null),
      unitPrice: json['unitPrice'] != null
          ? (json['unitPrice'] as num).toDouble()
          : null,
      subTotal: json['subTotal'] != null
          ? (json['subTotal'] as num).toDouble()
          : null,
      product: json['product'] != null
          ? ProductModel.fromJson(Map<String, dynamic>.from(json['product']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'invetoryId': invetoryId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'subTotal': subTotal,
      'product': product?.toJson(),
    };
  }
}
