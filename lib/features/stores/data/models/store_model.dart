class StoreModel {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  List<Data>? data;

  StoreModel({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    message = json['message'];
    errorsBag = json['errorsBag'];
    if (json['data'] is List) {
      data = (json['data'] as List).map((v) => Data.fromJson(v)).toList();
    } else if (json['data'] is Map<String, dynamic>) {
      data = [Data.fromJson(json['data'])];
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'succeeded': succeeded,
      'message': message,
      'errorsBag': errorsBag,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class Data {
  String? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? phone;

  Data({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
    address = json['address'];
    latitude = _parseDouble(json['latitude']);
    longitude = _parseDouble(json['longitude']);
    phone = json['phone']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
    };
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
