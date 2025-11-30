class BaseBoolResponse {
  int? statusCode;
  bool? succeeded;
  String? message;
  Map<String, dynamic>? errorsBag;
  bool? data;

  BaseBoolResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    errorsBag = json['errorsBag'];
    data = json['data'];
  }
}
