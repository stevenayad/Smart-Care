import 'package:equatable/equatable.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsStarted extends ProductsEvent {
  const ProductsStarted();
}

class ProductsCategoriesReloadRequested extends ProductsEvent {
  const ProductsCategoriesReloadRequested();
}

class ProductsCompaniesReloadRequested extends ProductsEvent {
  const ProductsCompaniesReloadRequested();
}

class ProductCategorySelected extends ProductsEvent {
  final String displayName;
  final String categoryId;

  const ProductCategorySelected({
    required this.displayName,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [displayName, categoryId];
}

class ProductCompanySelected extends ProductsEvent {
  final String displayName;
  final String companyId;

  const ProductCompanySelected({
    required this.displayName,
    required this.companyId,
  });

  @override
  List<Object?> get props => [displayName, companyId];
}

class ProductSearchAxisChanged extends ProductsEvent {
  final ProductsSearchAxis axis;

  const ProductSearchAxisChanged(this.axis);

  @override
  List<Object?> get props => [axis];
}

class ProductSearchInputChanged extends ProductsEvent {
  final String text;

  const ProductSearchInputChanged(this.text);

  @override
  List<Object?> get props => [text];
}

class ProductSearchCommitted extends ProductsEvent {
  final String trimmedQuery;

  const ProductSearchCommitted(this.trimmedQuery);

  @override
  List<Object?> get props => [trimmedQuery];
}

class ProductPageRequested extends ProductsEvent {
  final int page;

  const ProductPageRequested(this.page);

  @override
  List<Object?> get props => [page];
}

class ProductsRefreshRequested extends ProductsEvent {
  const ProductsRefreshRequested();
}

class ApplyProductFiltersSubmitted extends ProductsEvent {
  final String sortLabel;
  final String fromPriceText;
  final String toPriceText;
  final String fromRateText;
  final String toRateText;

  const ApplyProductFiltersSubmitted({
    required this.sortLabel,
    required this.fromPriceText,
    required this.toPriceText,
    required this.fromRateText,
    required this.toRateText,
  });

  @override
  List<Object?> get props => [
    sortLabel,
    fromPriceText,
    toPriceText,
    fromRateText,
    toRateText,
  ];
}
