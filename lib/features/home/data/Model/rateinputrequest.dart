class RateInputRequest {
  final String productId;
  final int value;
  final String createdAt;

  RateInputRequest({
    required this.productId,
    required this.value,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'value': value, 'createdAt': createdAt};
  }
}
