import 'dart:convert';

import 'data.dart';

class ProfileModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  Data? data;

  ProfileModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) => ProfileModel(
    statusCode: data['statusCode'] as int?,
    succeeded: data['succeeded'] as bool?,
    message: data['message'] as String?,
    errorsBag: data['errorsBag'] as dynamic,
    data: data['data'] == null
        ? null
        : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileModel].
  factory ProfileModel.fromJson(String data) {
    return ProfileModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
