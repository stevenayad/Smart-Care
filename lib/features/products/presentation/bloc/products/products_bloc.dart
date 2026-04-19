import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';
import 'package:smartcare/features/products/data/repository/product_repository.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

enum _ProductListReplayKind {
  all,
  companyById,
  categoryById,
  searchByName,
  searchByCompanyName,
  searchByCategoryName,
  searchByDescription,
  filter,
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this._repository) : super(ProductsState.initial()) {
    on<ProductsStarted>(_onStarted);
    on<ProductsCategoriesReloadRequested>(_onCategoriesReload);
    on<ProductsCompaniesReloadRequested>(_onCompaniesReload);
    on<ProductCategorySelected>(_onCategorySelected);
    on<ProductCompanySelected>(_onCompanySelected);
    on<ProductSearchAxisChanged>(_onSearchAxisChanged);
    on<ProductSearchInputChanged>(_onSearchInputChanged);
    on<ProductSearchCommitted>(_onSearchCommitted);
    on<ProductPageRequested>(_onPageRequested);
    on<ProductsRefreshRequested>(_onRefresh);
    on<ApplyProductFiltersSubmitted>(_onApplyFilters);
  }

  final ProductRepository _repository;

  static const int _searchDebounceMs = 500;

  _ProductListReplayKind _replayKind = _ProductListReplayKind.all;
  String? _replayCompanyId;
  String? _replayCategoryId;
  String? _replaySearchQuery;
  bool? _filterOrderByName;
  bool? _filterOrderByPrice;
  bool? _filterOrderByRate;
  double? _filterFromRate;
  double? _filterToRate;
  double? _filterFromPrice;
  double? _filterToPrice;

  Timer? _searchDebounce;
  String _pendingSearchText = '';

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    ProductsStarted event,
    Emitter<ProductsState> emit,
  ) async {
    await _loadSideLists(emit);
    _setReplayAll();
    await _fetchProductPage(emit, page: 1);
  }

  Future<void> _loadSideLists(Emitter<ProductsState> emit) async {
    emit(
      state.copyWith(
        categoriesStatus: ProductsSideListStatus.loading,
        companiesStatus: ProductsSideListStatus.loading,
        clearCategoriesError: true,
        clearCompaniesError: true,
      ),
    );

    final categoriesResult = await _repository.getCategories();
    categoriesResult.fold(
      (failure) => emit(
        state.copyWith(
          categoriesStatus: ProductsSideListStatus.failure,
          categoriesError: failure.errMessage,
        ),
      ),
      (list) => emit(
        state.copyWith(
          categoriesStatus: ProductsSideListStatus.success,
          categories: list,
          clearCategoriesError: true,
        ),
      ),
    );

    final companiesResult = await _repository.getCompanies();
    companiesResult.fold(
      (failure) => emit(
        state.copyWith(
          companiesStatus: ProductsSideListStatus.failure,
          companiesError: failure.errMessage,
        ),
      ),
      (list) => emit(
        state.copyWith(
          companiesStatus: ProductsSideListStatus.success,
          companies: list,
          clearCompaniesError: true,
        ),
      ),
    );
  }

  Future<void> _onCategoriesReload(
    ProductsCategoriesReloadRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        categoriesStatus: ProductsSideListStatus.loading,
        clearCategoriesError: true,
      ),
    );
    final result = await _repository.getCategories();
    result.fold(
      (failure) => emit(
        state.copyWith(
          categoriesStatus: ProductsSideListStatus.failure,
          categoriesError: failure.errMessage,
        ),
      ),
      (list) => emit(
        state.copyWith(
          categoriesStatus: ProductsSideListStatus.success,
          categories: list,
          clearCategoriesError: true,
        ),
      ),
    );
  }

  Future<void> _onCompaniesReload(
    ProductsCompaniesReloadRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        companiesStatus: ProductsSideListStatus.loading,
        clearCompaniesError: true,
      ),
    );
    final result = await _repository.getCompanies();
    result.fold(
      (failure) => emit(
        state.copyWith(
          companiesStatus: ProductsSideListStatus.failure,
          companiesError: failure.errMessage,
        ),
      ),
      (list) => emit(
        state.copyWith(
          companiesStatus: ProductsSideListStatus.success,
          companies: list,
          clearCompaniesError: true,
        ),
      ),
    );
  }

  Future<void> _onCategorySelected(
    ProductCategorySelected event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(selectedCategoryDisplayName: event.displayName));

    if (event.categoryId == 'all') {
      _setReplayAll();
    } else {
      _replayKind = _ProductListReplayKind.categoryById;
      _replayCategoryId = event.categoryId;
    }

    await _fetchProductPage(emit, page: 1);
  }

  Future<void> _onCompanySelected(
    ProductCompanySelected event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(selectedCompanyDisplayName: event.displayName));

    if (event.companyId == 'all') {
      _setReplayAll();
    } else {
      _replayKind = _ProductListReplayKind.companyById;
      _replayCompanyId = event.companyId;
    }

    await _fetchProductPage(emit, page: 1);
  }

  void _onSearchAxisChanged(
    ProductSearchAxisChanged event,
    Emitter<ProductsState> emit,
  ) {
    emit(
      state.copyWith(
        searchAxis: event.axis,
        searchAxisLabel: _searchAxisLabel(event.axis),
      ),
    );
  }

  String _searchAxisLabel(ProductsSearchAxis axis) {
    switch (axis) {
      case ProductsSearchAxis.name:
        return 'Name';
      case ProductsSearchAxis.company:
        return 'Company';
      case ProductsSearchAxis.category:
        return 'Category';
      case ProductsSearchAxis.description:
        return 'Description';
    }
  }

  void _onSearchInputChanged(
    ProductSearchInputChanged event,
    Emitter<ProductsState> emit,
  ) {
    _pendingSearchText = event.text;
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: _searchDebounceMs),
      () => add(ProductSearchCommitted(_pendingSearchText.trim())),
    );
  }

  Future<void> _onSearchCommitted(
    ProductSearchCommitted event,
    Emitter<ProductsState> emit,
  ) async {
    final query = event.trimmedQuery;

    if (query.isEmpty) {
      _setReplayAll();
      await _fetchProductPage(emit, page: 1);
      return;
    }

    switch (state.searchAxis) {
      case ProductsSearchAxis.name:
        _replayKind = _ProductListReplayKind.searchByName;
        _replaySearchQuery = query;
        break;
      case ProductsSearchAxis.company:
        _replayKind = _ProductListReplayKind.searchByCompanyName;
        _replaySearchQuery = query;
        break;
      case ProductsSearchAxis.category:
        _replayKind = _ProductListReplayKind.searchByCategoryName;
        _replaySearchQuery = query;
        break;
      case ProductsSearchAxis.description:
        _replayKind = _ProductListReplayKind.searchByDescription;
        _replaySearchQuery = query;
        break;
    }

    await _fetchProductPage(emit, page: 1);
  }

  Future<void> _onPageRequested(
    ProductPageRequested event,
    Emitter<ProductsState> emit,
  ) async {
    if (event.page < 1) {
      return;
    }
    await _fetchProductPage(emit, page: event.page);
  }

  Future<void> _onRefresh(
    ProductsRefreshRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        productsStatus: ProductsListStatus.loading,
        clearProductsError: true,
      ),
    );
    await _loadSideLists(emit);
    await _fetchProductPage(emit, page: state.currentPage);
  }

  Future<void> _onApplyFilters(
    ApplyProductFiltersSubmitted event,
    Emitter<ProductsState> emit,
  ) async {
    bool? orderByName;
    bool? orderByPrice;
    bool? orderByRate;

    switch (event.sortLabel) {
      case 'Name A to Z':
        orderByName = true;
        break;
      case 'Name Z to A':
        orderByName = false;
        break;
      case 'Price: Low to High':
        orderByPrice = true;
        break;
      case 'Price: High to Low':
        orderByPrice = false;
        break;
      case 'Rate: Low to High':
        orderByRate = true;
        break;
      case 'Rate: High to Low':
        orderByRate = false;
        break;
      default:
        orderByName = null;
        orderByPrice = null;
        orderByRate = null;
        break;
    }

    _replayKind = _ProductListReplayKind.filter;
    _filterOrderByName = orderByName;
    _filterOrderByPrice = orderByPrice;
    _filterOrderByRate = orderByRate;
    _filterFromPrice = double.tryParse(event.fromPriceText);
    _filterToPrice = double.tryParse(event.toPriceText);
    _filterFromRate = double.tryParse(event.fromRateText);
    _filterToRate = double.tryParse(event.toRateText);

    await _fetchProductPage(emit, page: 1);
  }

  void _setReplayAll() {
    _replayKind = _ProductListReplayKind.all;
    _replayCompanyId = null;
    _replayCategoryId = null;
    _replaySearchQuery = null;
    _filterOrderByName = null;
    _filterOrderByPrice = null;
    _filterOrderByRate = null;
    _filterFromRate = null;
    _filterToRate = null;
    _filterFromPrice = null;
    _filterToPrice = null;
  }

  Future<void> _fetchProductPage(
    Emitter<ProductsState> emit, {
    required int page,
  }) async {
    emit(
      state.copyWith(
        productsStatus: ProductsListStatus.loading,
        clearProductsError: true,
      ),
    );

    final pageSize = state.pageSize;
    final Either<servivefailure, List<ProductModel>> result;

    switch (_replayKind) {
      case _ProductListReplayKind.all:
        result = await _repository.getProducts(
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.companyById:
        result = await _repository.getProductsByCompanyId(
          companyId: _replayCompanyId ?? '',
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.categoryById:
        result = await _repository.getProductsByCategoryId(
          categoryId: _replayCategoryId ?? '',
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.searchByName:
        result = await _repository.getProductsByName(
          name: _replaySearchQuery ?? '',
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.searchByCompanyName:
        result = await _repository.getProductsByCompanyName(
          companyName: _replaySearchQuery ?? '',
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.searchByCategoryName:
        result = await _repository.getProductsByCategoryName(
          categoryName: _replaySearchQuery ?? '',
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.searchByDescription:
        result = await _repository.getProductsByDescription(
          description: _replaySearchQuery ?? '',
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
      case _ProductListReplayKind.filter:
        result = await _repository.filterProducts(
          orderByName: _filterOrderByName,
          orderByPrice: _filterOrderByPrice,
          orderByRate: _filterOrderByRate,
          fromRate: _filterFromRate,
          toRate: _filterToRate,
          fromPrice: _filterFromPrice,
          toPrice: _filterToPrice,
          pageNumber: page,
          pageSize: pageSize,
        );
        break;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          productsStatus: ProductsListStatus.failure,
          productsError: failure.errMessage,
          products: const [],
          productsContentVersion: state.productsContentVersion + 1,
        ),
      ),
      (products) => emit(
        state.copyWith(
          productsStatus: ProductsListStatus.success,
          products: products,
          currentPage: page,
          clearProductsError: true,
          productsContentVersion: state.productsContentVersion + 1,
        ),
      ),
    );
  }
}
