import 'package:smartcare/features/order/data/model/pickup_order_model/outof_stock.dart';
import 'item.dart';

class pickupData {
  String? id;
  String? clientId;
  int? paymentId;
  String? storeId;
  double? totalPrice;
  int? status;
  DateTime? createdAt;
  List<OutOfStock>? outOfStocks;
  List<Item>? items;

  pickupData({
    this.id,
    this.clientId,
    this.paymentId,
    this.storeId,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.outOfStocks,
    this.items,
  });

  factory pickupData.fromJson(Map<String, dynamic> json) => pickupData(
    id: json['id'] as String?,
    clientId: json['clientId'] as String?,
    paymentId: json['paymentId'] as int?,
    storeId: json['storeId'] as String?,
    totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    status: json['status'] as int?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    outOfStocks: (json['outOfStocks'] as List<dynamic>?)
        ?.map((e) => OutOfStock.fromJson(e as Map<String, dynamic>))
        .toList(),
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientId': clientId,
    'paymentId': paymentId,
    'storeId': storeId,
    'totalPrice': totalPrice,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'outOfStocks': outOfStocks,
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
