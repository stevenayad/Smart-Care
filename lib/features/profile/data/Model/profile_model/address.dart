import 'dart:convert';

class Address {
  String? address;
  String? label;
  String? additionalInfo;
  double? latitude;
  double? longitude;
  bool? isPrimary;

  Address({
    this.address,
    this.label,
    this.additionalInfo,
    this.latitude,
    this.longitude,
    this.isPrimary,
  });

  factory Address.fromMap(Map<String, dynamic> data) => Address(
    address: data['address'] as String?,
    label: data['label'] as String?,
    additionalInfo: data['additionalInfo'] as String?,
    latitude: (data['latitude'] as num?)?.toDouble(),
    longitude: (data['longitude'] as num?)?.toDouble(),
    isPrimary: data['isPrimary'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'address': address,
    'label': label,
    'additionalInfo': additionalInfo,
    'latitude': latitude,
    'longitude': longitude,
    'isPrimary': isPrimary,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
  factory Address.fromJson(String data) {
    return Address.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
  String toJson() => json.encode(toMap());
}
