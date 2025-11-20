class CategoryDatum {
  String? id;
  String? name;
  String? logoUrl;

  CategoryDatum({this.id, this.name, this.logoUrl});

  factory CategoryDatum.fromJson(Map<String, dynamic> json) => CategoryDatum(
    id: json['id'] as String?,
    name: json['name'] as String?,
    logoUrl: json['logoUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'logoUrl': logoUrl};
}
