import 'data.dart';
import 'errors_bag.dart';

class Profiledata {
  int? statusCode;
  bool? succeeded;
  String? message;
  ErrorsBag? errorsBag;
  Data? data;

  Profiledata({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory Profiledata.fromJson(Map<String, dynamic> json) => Profiledata(
    statusCode: json['statusCode'] as int?,
    succeeded: json['succeeded'] as bool?,
    message: json['message'] as String?,
    errorsBag: json['errorsBag'] == null
        ? null
        : ErrorsBag.fromJson(json['errorsBag'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag?.toJson(),
    'data': data?.toJson(),
  };
}
