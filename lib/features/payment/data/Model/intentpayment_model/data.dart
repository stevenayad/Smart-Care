class Data {
  String? clientSecret;
  String? paymentIntentId;
  double? amount;

  Data({this.clientSecret, this.paymentIntentId, this.amount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clientSecret: json['clientSecret'] as String?,
    paymentIntentId: json['paymentIntentId'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'clientSecret': clientSecret,
    'paymentIntentId': paymentIntentId,
    'amount': amount,
  };
}
