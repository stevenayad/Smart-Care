class MedicalWarningData {
  final String productId;
  final String productName;
  final String productImageUrl;
  final String ingredientA;
  final String ingredientB;
  final String reason;
  final String severity;
  final int severityLevel;
  final DateTime purchaseDate;

  MedicalWarningData({
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.ingredientA,
    required this.ingredientB,
    required this.reason,
    required this.severity,
    required this.severityLevel,
    required this.purchaseDate,
  });

  factory MedicalWarningData.fromJson(Map<String, dynamic> json) {
    return MedicalWarningData(
      productId: json['productId'],
      productName: json['productName'],
      productImageUrl: json['productImageUrl'],
      ingredientA: json['ingredientA'],
      ingredientB: json['ingredientB'],
      reason: json['reason'],
      severity: json['severity'],
      severityLevel: json['severityLevel'],
      purchaseDate: DateTime.parse(json['purchaseDate']),
    );
  }
}
