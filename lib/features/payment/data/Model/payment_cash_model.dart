class PaymentCashModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  bool? data;

  PaymentCashModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory PaymentCashModel.fromJson(Map<String, dynamic> json) {
    return PaymentCashModel(
      statusCode: json['statusCode'] as int?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errorsBag: json['errorsBag'] as dynamic,
      data: json['data'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data,
  };
}
