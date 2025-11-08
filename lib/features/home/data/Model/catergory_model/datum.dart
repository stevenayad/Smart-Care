class Datum {
  String? id;
  String? name;
  String? logoUrl;

  Datum({this.id, this.name, this.logoUrl});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as String?,
    name: json['name'] as String?,
    logoUrl: json['logoUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'logoUrl': logoUrl};
}
