import 'package:smartcare/features/cart/data/model/items_cart/datum.dart';

class UpdateDataModel {
  String? id;
  String? productId;
  String? productName;
  String? mainImageUrl;
  int? quantity;
  int? unitPrice;
  int? totalPrice;
  String? reservationId;
  DateTime? reservedUntil;

  UpdateDataModel({
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

factory UpdateDataModel.fromJson(Map<String, dynamic> json) =>
    UpdateDataModel(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      mainImageUrl: json['mainImageUrl'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      reservationId: json['reservationId'] as String?,
      reservedUntil: json['reservedUntil'] == null
          ? null
          : DateTime.parse(json['reservedUntil']),
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

DatumCart mapUpdateDataToDatumCart(UpdateDataModel d) {
  return DatumCart(
    id: d.id,
    productId: d.productId,
    productName: d.productName,
    mainImageUrl: d.mainImageUrl,
    quantity: d.quantity,
    unitPrice: d.unitPrice?.toDouble(),
    totalPrice: d.totalPrice?.toDouble(),
    reservationId: d.reservationId,
    reservedUntil: d.reservedUntil,
  );
}
