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
  const LoadProductsByCompany(this.companyId);
}

class SearchProducts extends ProductsEvent {
  final String query;
  const SearchProducts(this.query);
}

class SearchProductsByCompanyName extends ProductsEvent {
  final String companyName;
  const SearchProductsByCompanyName(this.companyName);
}

class SearchProductsByCategoryName extends ProductsEvent {
  final String categoryName;
  const SearchProductsByCategoryName(this.categoryName);
}

class SearchProductsByDescription extends ProductsEvent {
  final String description;
  const SearchProductsByDescription(this.description);
}

class LoadProductsByCategoryId extends ProductsEvent {
  final String categoryId;
  const LoadProductsByCategoryId(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
