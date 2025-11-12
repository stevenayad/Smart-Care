class RateModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  dynamic data;

  RateModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
    statusCode: json['statusCode'] as int?,
    succeeded: json['succeeded'] as bool?,
    message: json['message'] as String?,
    errorsBag: json['errorsBag'] as dynamic,
    data: json['data'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data,
  };
}
