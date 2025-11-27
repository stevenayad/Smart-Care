class UpdateProfileImage {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  String? data;

  UpdateProfileImage({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory UpdateProfileImage.fromJson(Map<String, dynamic> json) {
    return UpdateProfileImage(
      statusCode: json['statusCode'] as int?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errorsBag: json['errorsBag'] as dynamic,
      data: json['data'] as String?,
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
