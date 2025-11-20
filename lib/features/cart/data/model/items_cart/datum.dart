class DatumCart {
  String? id;
  String? productId;
  String? productName;
  String? mainImageUrl;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  String? reservationId;
  DateTime? reservedUntil;

  DatumCart({
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

  factory DatumCart.fromJson(Map<String, dynamic> json) => DatumCart(
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
