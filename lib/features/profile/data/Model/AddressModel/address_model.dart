class AddressModel {
  final String id;
  final String address;
  final String label;
  final String additionalInfo;
  final double latitude;
  final double longitude;
  final bool isPrimary;

  AddressModel({
    required this.id,
    required this.address,
    required this.label,
    required this.additionalInfo,
    required this.latitude,
    required this.longitude,
    required this.isPrimary,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      address: json['address'] ?? '',
      label: json['label'] ?? '',
      additionalInfo: json['additionalInfo'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      isPrimary: json['isPrimary'] ?? false,
    );
  }
}
