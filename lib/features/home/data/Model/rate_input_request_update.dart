class RateInputRequestUpdate {
  final String? id;
  final String productId;
  final int value;
  final String createdAt;

  RateInputRequestUpdate({
    this.id,
    required this.productId,
    required this.value,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "value": value,
    "createdAt": createdAt,
  };
}
