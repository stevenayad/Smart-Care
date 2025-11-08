import 'package:equatable/equatable.dart';

class CompanyModel extends Equatable {
  final String id;
  final String name;
  final int productsCount;
  final String logoUrl;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.logoUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      productsCount: (json['productsCount']?.toInt() ?? 0),
      logoUrl: json['logoUrl']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [id];
}
