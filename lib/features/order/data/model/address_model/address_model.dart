import 'datum.dart';

class AddressModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  List<AddressDatum>? data;

  AddressModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    statusCode: json['statusCode'] as int?,
    succeeded: json['succeeded'] as bool?,
    message: json['message'] as String?,
    errorsBag: json['errorsBag'] as dynamic,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => AddressDatum.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
