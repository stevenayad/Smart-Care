import 'datum.dart';

class ItemsCart {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  List<DatumCart>? data;

  ItemsCart({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory ItemsCart.fromJson(Map<String, dynamic> json) => ItemsCart(
    statusCode: json['statusCode'] as int?,
    succeeded: json['succeeded'] as bool?,
    message: json['message'] as String?,
    errorsBag: json['errorsBag'] as dynamic,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => DatumCart.fromJson(e as Map<String, dynamic>))
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
