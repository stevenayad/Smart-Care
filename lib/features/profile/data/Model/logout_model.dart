class LogoutModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  bool? data;

  LogoutModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    statusCode: json['statusCode'] as int?,
    succeeded: json['succeeded'] as bool?,
    message: json['message'] as String?,
    errorsBag: json['errorsBag'] as dynamic,
    data: json['data'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data,
  };
}
