class RemoveItemCartModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  bool? data;

  RemoveItemCartModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory RemoveItemCartModel.fromJson(Map<String, dynamic> json) {
    return RemoveItemCartModel(
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
