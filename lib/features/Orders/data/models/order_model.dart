import 'package:smartcare/features/Orders/data/models/store_model.dart';

import 'address_model.dart';
import 'order_item_model.dart';
import 'out_of_stock_model.dart';

class OrderModel {
  final String id;
  final String? clientId;
  final int? paymentId;
  final AddressModel? address;
  final StoreModel? store; // <-- unified
  final double? totalPrice;
  final int? status;
  final DateTime? createdAt;
  final List<OrderItemModel>? orderItems;
  final List<OutOfStockModel>? outOfStocks;

  OrderModel({
    required this.id,
    this.clientId,
    this.paymentId,
    this.address,
    this.store,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.orderItems,
    this.outOfStocks,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      clientId: json['clientId'] as String?,
      paymentId: json['paymentId'] is int
          ? json['paymentId'] as int
          : (json['paymentId'] != null
                ? int.tryParse(json['paymentId'].toString())
                : null),
      address: json['address'] != null
          ? AddressModel.fromJson(Map<String, dynamic>.from(json['address']))
          : null,
      store: json['store'] != null
          ? StoreModel.fromJson(Map<String, dynamic>.from(json['store']))
          : null,
      totalPrice: json['totalPrice'] != null
          ? (json['totalPrice'] as num).toDouble()
          : null,
      status: json['status'] is int
          ? json['status'] as int
          : (json['status'] != null
                ? int.tryParse(json['status'].toString())
                : null),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      orderItems: json['orderItems'] != null
          ? List<Map<String, dynamic>>.from(
              json['orderItems'],
            ).map((e) => OrderItemModel.fromJson(e)).toList()
          : null,
      outOfStocks: json['outOfStocks'] != null
          ? List<Map<String, dynamic>>.from(
              json['outOfStocks'],
            ).map((e) => OutOfStockModel.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'paymentId': paymentId,
      'address': address?.toJson(),
      'store': store?.toJson(),
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'orderItems': orderItems?.map((e) => e.toJson()).toList(),
      'outOfStocks': outOfStocks?.map((e) => e.toJson()).toList(),
    };
  }
}
