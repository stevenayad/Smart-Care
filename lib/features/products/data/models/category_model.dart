import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final int productsCount;
  final String logoUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.logoUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      productsCount: json['productsCount'] ?? 0,
      logoUrl: json['logoUrl']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [id];
}
