import 'item.dart';

class BestSellerData {
  List<BestSellerItem>? items;
  int? totalCount;
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;

  BestSellerData({
    this.items,
    this.totalCount,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory BestSellerData.fromJson(Map<String, dynamic> json) => BestSellerData(
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => BestSellerItem.fromJson(e as Map<String, dynamic>))
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
