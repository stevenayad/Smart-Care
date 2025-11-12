import 'item.dart';

class Data {
  List<ProductItemModel>? items;
  int? totalCount;
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;

  Data({
    this.items,
    this.totalCount,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalCount: json['totalCount'] as int?,
    pageNumber: json['pageNumber'] as int?,
    pageSize: json['pageSize'] as int?,
    totalPages: json['totalPages'] as int?,
    hasNext: json['hasNext'] as bool?,
    hasPrevious: json['hasPrevious'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'items': items?.map((e) => e.toJson()).toList(),
    'totalCount': totalCount,
    'pageNumber': pageNumber,
    'pageSize': pageSize,
    'totalPages': totalPages,
    'hasNext': hasNext,
    'hasPrevious': hasPrevious,
  };
}
