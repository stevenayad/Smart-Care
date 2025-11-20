import 'package:smartcare/features/cart/data/model/items_cart/datum.dart';
import 'package:smartcare/features/cart/data/model/update_cart_item_model/data.dart';
import 'package:smartcare/features/home/data/Model/category_paginted_model/data.dart';

class AddDataModel {
  String? id;
  String? productId;
  String? productName;
  String? mainImageUrl;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  String? reservationId;
  DateTime? reservedUntil;

  AddDataModel({
    this.id,
    this.productId,
    this.productName,
    this.mainImageUrl,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.reservationId,
    this.reservedUntil,
  });

  factory AddDataModel.fromJson(Map<String, dynamic> json) => AddDataModel(
    id: json['id'] as String?,
    productId: json['productId'] as String?,
    productName: json['productName'] as String?,
    mainImageUrl: json['mainImageUrl'] as String?,
    quantity: json['quantity'] as int?,
    unitPrice: (json['unitPrice'] as num?)?.toDouble(),
    totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    reservationId: json['reservationId'] as String?,
    reservedUntil: json['reservedUntil'] == null
        ? null
        : DateTime.parse(json['reservedUntil'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'productId': productId,
    'productName': productName,
    'mainImageUrl': mainImageUrl,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'totalPrice': totalPrice,
    'reservationId': reservationId,
    'reservedUntil': reservedUntil?.toIso8601String(),
  };

}

  DatumCart mapAddDataToDatumCart(AddDataModel d) {
  return DatumCart(
    id: d.id,
    productId: d.productId,
    productName: d.productName,
    mainImageUrl: d.mainImageUrl,
    quantity: d.quantity,
    unitPrice: d.unitPrice,
    totalPrice: d.totalPrice,
  );
}
