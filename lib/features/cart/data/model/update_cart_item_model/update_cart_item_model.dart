import 'data.dart';
import 'errors_bag.dart';

class UpdateCartItemModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  ErrorsBag? errorsBag;
  UpdateDataModel? data;

  UpdateCartItemModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory UpdateCartItemModel.fromJson(Map<String, dynamic> json) {
    return UpdateCartItemModel(
      statusCode: json['statusCode'] as int?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errorsBag: json['errorsBag'] == null
          ? null
          : ErrorsBag.fromJson(json['errorsBag'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : UpdateDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag?.toJson(),
    'data': data?.toJson(),
  };
}
