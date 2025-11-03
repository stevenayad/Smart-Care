class Datum {
  String? id;
  String? name;
  int? productsCount;
  String? logoUrl;

  Datum({this.id, this.name, this.productsCount, this.logoUrl});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as String?,
    name: json['name'] as String?,
    productsCount: json['productsCount'] as int?,
    logoUrl: json['logoUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'productsCount': productsCount,
    'logoUrl': logoUrl,
  };
}
