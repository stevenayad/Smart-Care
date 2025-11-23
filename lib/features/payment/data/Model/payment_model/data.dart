class Data {
  String? url;
  String? id;

  Data({this.url, this.id});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(url: json['url'] as String?, id: json['id'] as String?);

  Map<String, dynamic> toJson() => {'url': url, 'id': id};
}
