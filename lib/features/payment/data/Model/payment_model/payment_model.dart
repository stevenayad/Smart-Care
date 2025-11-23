import 'data.dart';

class PaymentModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  Data? data;

  PaymentModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    statusCode: json['statusCode'] as int?,
    succeeded: json['succeeded'] as bool?,
    message: json['message'] as String?,
    errorsBag: json['errorsBag'] as dynamic,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data?.toJson(),
  };
}
