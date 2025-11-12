import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {
  final int pageNumber;
  final int pageSize;

  const LoadProducts({this.pageNumber = 1, this.pageSize = 10});
}

class LoadProductsByCompany extends ProductsEvent {
  final String companyId;
  final int pageNumber;
  final int pageSize;
  const LoadProductsByCompany(this.companyId, this.pageNumber, this.pageSize);
}

class SearchProducts extends ProductsEvent {
  final String query;
   final int pageNumber;
  final int pageSize;
  const SearchProducts(this.query, this.pageNumber, this.pageSize);
}

class SearchProductsByCompanyName extends ProductsEvent {
  final String companyName;
   final int pageNumber;
  final int pageSize;
  const SearchProductsByCompanyName(this.companyName, this.pageNumber, this.pageSize);
}

class SearchProductsByCategoryName extends ProductsEvent {
  final String categoryName;
   final int pageNumber;
  final int pageSize;
  const SearchProductsByCategoryName(this.categoryName, this.pageNumber, this.pageSize);
}

class SearchProductsByDescription extends ProductsEvent {
  final String description;
   final int pageNumber;
  final int pageSize;
  const SearchProductsByDescription(this.description, this.pageNumber, this.pageSize);
}

class LoadProductsByCategoryId extends ProductsEvent {
  final String categoryId;
  final int pageNumber;
  final int pageSize;
  const LoadProductsByCategoryId(this.categoryId, this.pageNumber, this.pageSize);

  @override
  List<Object?> get props => [categoryId];
}
class FilterProducts extends ProductsEvent {
  final bool? orderByName;
  final bool? orderByPrice;
  final bool? orderByRate;
  final double? fromRate;
  final double? toRate;
  final double? fromPrice;
  final double? toPrice;
  final int pageNumber;
  final int pageSize;

  const FilterProducts({
    this.orderByName,
    this.orderByPrice,
    this.orderByRate,
    this.fromRate,
    this.toRate,
    this.fromPrice,
    this.toPrice,
    this.pageNumber = 1,
    this.pageSize = 10,
  });
}

