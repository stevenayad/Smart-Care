class AddressModel {
  final String? address;
  final String? label;
  final String? additionalInfo;
  final double? latitude;
  final double? longitude;
  final bool? isPrimary;

  AddressModel({
    this.address,
    this.label,
    this.additionalInfo,
    this.latitude,
    this.longitude,
    this.isPrimary,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'] as String?,
      label: json['label'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      isPrimary: json['isPrimary'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'label': label,
      'additionalInfo': additionalInfo,
      'latitude': latitude,
      'longitude': longitude,
      'isPrimary': isPrimary,
    };
  }
}
