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

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json['address'] as String?,
    label: json['label'] as String?,
    additionalInfo: json['additionalInfo'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    isPrimary: json['isPrimary'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'address': address,
    'label': label,
    'additionalInfo': additionalInfo,
    'latitude': latitude,
    'longitude': longitude,
    'isPrimary': isPrimary,
  };
}
