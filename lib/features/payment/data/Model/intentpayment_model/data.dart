class Data {
  String? clientPaymentToken;
  String? providerReferenceId;
  int? provider;

  Data({this.clientPaymentToken, this.providerReferenceId, this.provider});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clientPaymentToken: json['clientPaymentToken'] as String?,
    providerReferenceId: json['providerReferenceId'] as String?,
    provider: json['provider'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'clientPaymentToken': clientPaymentToken,
    'providerReferenceId': providerReferenceId,
    'provider': provider,
  };
}
