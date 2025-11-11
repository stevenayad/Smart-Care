class FavouriteModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  bool? data;

  FavouriteModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
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
