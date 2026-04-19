import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_event.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_state.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

class ProductUiBloc extends Bloc<ProductUiEvent, ProductUiState> {
  ProductUiBloc(this._productsBloc) : super(ProductUiState.initial()) {
    on<ProductUiProductsStateSynced>(_onProductsStateSynced);
    on<CategoryToolbarTapped>(_onCategoryToolbarTapped);
    on<CompanyToolbarTapped>(_onCompanyToolbarTapped);
    on<FilterToolbarTapped>(_onFilterToolbarTapped);
    on<ProductCategorySheetDismissed>(_onCategorySheetDismissed);
    on<ProductCompanySheetDismissed>(_onCompanySheetDismissed);
    on<ProductFilterSheetDismissed>(_onFilterSheetDismissed);

    _productsSubscription = _productsBloc.stream.listen(
      (s) => add(ProductUiProductsStateSynced(s)),
    );
    add(ProductUiProductsStateSynced(_productsBloc.state));
  }

  final ProductsBloc _productsBloc;
  StreamSubscription<ProductsState>? _productsSubscription;

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }

  void _onProductsStateSynced(
    ProductUiProductsStateSynced event,
    Emitter<ProductUiState> emit,
  ) {
    emit(
      state.copyWith(
        categoryButtonLabel: _categoryLabel(event.productsState),
        companyButtonLabel: _companyLabel(event.productsState),
      ),
    );
  }

  String _categoryLabel(ProductsState s) {
    switch (s.categoriesStatus) {
      case ProductsSideListStatus.initial:
      case ProductsSideListStatus.loading:
        return 'Loading...';
      case ProductsSideListStatus.failure:
        return 'Retry Categories';
      case ProductsSideListStatus.success:
        return 'Category';
    }
  }

  String _companyLabel(ProductsState s) {
    switch (s.companiesStatus) {
      case ProductsSideListStatus.initial:
      case ProductsSideListStatus.loading:
        return 'Loading...';
      case ProductsSideListStatus.failure:
        return 'Retry Companies';
      case ProductsSideListStatus.success:
        return 'Company';
    }
  }

  void _onCategoryToolbarTapped(
    CategoryToolbarTapped event,
    Emitter<ProductUiState> emit,
  ) {
    final s = _productsBloc.state;
    switch (s.categoriesStatus) {
      case ProductsSideListStatus.initial:
      case ProductsSideListStatus.loading:
        _productsBloc.add(const ProductsCategoriesReloadRequested());
        return;
      case ProductsSideListStatus.failure:
        _productsBloc.add(const ProductsCategoriesReloadRequested());
        return;
      case ProductsSideListStatus.success:
        emit(
          state.copyWith(
            categorySheetNonce: state.categorySheetNonce + 1,
            categorySheetSnap: CategorySheetSnap(
              categories: s.categories,
              selectedName: s.selectedCategoryDisplayName,
            ),
          ),
        );
        return;
    }
  }

  void _onCompanyToolbarTapped(
    CompanyToolbarTapped event,
    Emitter<ProductUiState> emit,
  ) {
    final s = _productsBloc.state;
    switch (s.companiesStatus) {
      case ProductsSideListStatus.initial:
      case ProductsSideListStatus.loading:
        _productsBloc.add(const ProductsCompaniesReloadRequested());
        return;
      case ProductsSideListStatus.failure:
        _productsBloc.add(const ProductsCompaniesReloadRequested());
        return;
      case ProductsSideListStatus.success:
        emit(
          state.copyWith(
            companySheetNonce: state.companySheetNonce + 1,
            companySheetSnap: CompanySheetSnap(
              companies: s.companies,
              selectedName: s.selectedCompanyDisplayName,
            ),
          ),
        );
        return;
    }
  }

  void _onFilterToolbarTapped(
    FilterToolbarTapped event,
    Emitter<ProductUiState> emit,
  ) {
    emit(state.copyWith(filterSheetNonce: state.filterSheetNonce + 1));
  }

  void _onCategorySheetDismissed(
    ProductCategorySheetDismissed event,
    Emitter<ProductUiState> emit,
  ) {
    emit(state.copyWith(clearCategorySheetSnap: true));
  }

  void _onCompanySheetDismissed(
    ProductCompanySheetDismissed event,
    Emitter<ProductUiState> emit,
  ) {
    emit(state.copyWith(clearCompanySheetSnap: true));
  }

  void _onFilterSheetDismissed(
    ProductFilterSheetDismissed event,
    Emitter<ProductUiState> emit,
  ) {
    // Reserved for future filter-sheet UI state; modal is driven by nonce only.
  }
}
