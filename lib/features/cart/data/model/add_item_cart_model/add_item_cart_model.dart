import 'data.dart';

class AddItemCartModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  AddDataModel? data;

  AddItemCartModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory AddItemCartModel.fromJson(Map<String, dynamic> json) {
    return AddItemCartModel(
      statusCode: json['statusCode'] as int?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errorsBag: json['errorsBag'] as dynamic,
      data: json['data'] == null
          ? null
          : AddDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data?.toJson(),
  };
}
