class OutOfStockModel {
  final String? productId;
  final int? requestedQty;
  final int? availableQty;

  OutOfStockModel({
    this.productId,
    this.requestedQty,
    this.availableQty,
  });

  factory OutOfStockModel.fromJson(Map<String, dynamic> json) {
    return OutOfStockModel(
      productId: json['productId'] as String?,
      requestedQty: json['requestedQty'] is int ? json['requestedQty'] as int : (json['requestedQty'] != null ? int.tryParse(json['requestedQty'].toString()) : null),
      availableQty: json['availableQty'] is int ? json['availableQty'] as int : (json['availableQty'] != null ? int.tryParse(json['availableQty'].toString()) : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'requestedQty': requestedQty,
      'availableQty': availableQty,
    };
  }
}
