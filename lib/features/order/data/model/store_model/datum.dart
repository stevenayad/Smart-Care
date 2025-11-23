class StoreDatum {
  String? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  String? phone;

  StoreDatum({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
  });

  factory StoreDatum.fromJson(Map<String, dynamic> json) => StoreDatum(
    id: json['id'] as String?,
    name: json['name'] as String?,
    address: json['address'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    phone: json['phone'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'phone': phone,
  };
}
