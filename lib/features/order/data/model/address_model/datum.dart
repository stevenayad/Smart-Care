class AddressDatum {
  String? id;
  String? address;
  String? label;
  String? additionalInfo;
  double? latitude;
  double? longitude;
  bool? isPrimary;

  AddressDatum({
    this.id,
    this.address,
    this.label,
    this.additionalInfo,
    this.latitude,
    this.longitude,
    this.isPrimary,
  });

  factory AddressDatum.fromJson(Map<String, dynamic> json) => AddressDatum(
    id: json['id'] as String?,
    address: json['address'] as String?,
    label: json['label'] as String?,
    additionalInfo: json['additionalInfo'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    isPrimary: json['isPrimary'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'address': address,
    'label': label,
    'additionalInfo': additionalInfo,
    'latitude': latitude,
    'longitude': longitude,
    'isPrimary': isPrimary,
  };
}
