import 'package:equatable/equatable.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

abstract class ProductUiEvent extends Equatable {
  const ProductUiEvent();

  @override
  List<Object?> get props => [];
}

class ProductUiProductsStateSynced extends ProductUiEvent {
  final ProductsState productsState;

  const ProductUiProductsStateSynced(this.productsState);

  @override
  List<Object?> get props => [productsState];
}

class CategoryToolbarTapped extends ProductUiEvent {
  const CategoryToolbarTapped();
}

class CompanyToolbarTapped extends ProductUiEvent {
  const CompanyToolbarTapped();
}

class FilterToolbarTapped extends ProductUiEvent {
  const FilterToolbarTapped();
}

class ProductCategorySheetDismissed extends ProductUiEvent {
  const ProductCategorySheetDismissed();
}

class ProductCompanySheetDismissed extends ProductUiEvent {
  const ProductCompanySheetDismissed();
}

class ProductFilterSheetDismissed extends ProductUiEvent {
  const ProductFilterSheetDismissed();
}
