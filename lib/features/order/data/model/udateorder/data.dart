import 'address.dart';
import 'order_item.dart';

class Data {
  String? id;
  String? clientId;
  Address? address;
  dynamic store;
  double? totalPrice;
  int? status;
  DateTime? createdAt;
  List<OrderItem>? orderItems;

  Data({
    this.id,
    this.clientId,
    this.address,
    this.store,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.orderItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as String?,
    clientId: json['clientId'] as String?,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    store: json['store'] as dynamic,
    totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    status: json['status'] as int?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    orderItems: (json['orderItems'] as List<dynamic>?)
        ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientId': clientId,
    'address': address?.toJson(),
    'store': store,
    'totalPrice': totalPrice,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'orderItems': orderItems?.map((e) => e.toJson()).toList(),
  };
}
