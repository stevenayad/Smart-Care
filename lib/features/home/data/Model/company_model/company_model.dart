import 'datum.dart';

class CompanyModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  List<Datum>? data;

  CompanyModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<Datum>? datumList;

    if (rawData is List) {
      datumList = rawData
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      datumList = [Datum.fromJson(rawData)];
    }

    return CompanyModel(
      statusCode: json['statusCode'] as int?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errorsBag: json['errorsBag'],
      data: datumList,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
