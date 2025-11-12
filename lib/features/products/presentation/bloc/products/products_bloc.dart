import 'package:bloc/bloc.dart';
import 'products_event.dart';
import 'products_state.dart';
import '../../../data/repositories/products_repository_impl.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepositoryImpl repository;
  ProductsEvent? lastEvent;

  ProductsBloc(this.repository) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByCompany>(_onLoadByCompany);
    on<SearchProducts>(_onSearchProducts);
    on<SearchProductsByCompanyName>(_onSearchByCompanyName);
    on<SearchProductsByCategoryName>(_onSearchByCategoryName);
    on<SearchProductsByDescription>(_onSearchByDescription);
    on<LoadProductsByCategoryId>(_onLoadProductsByCategoryId);
    on<FilterProducts>(_onFilterProducts);
  }
  Future<void> _handleEvent(ProductsEvent event) async {
    lastEvent = event;
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProducts(
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onLoadByCompany(
    LoadProductsByCompany event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProductsByCompanyId(
      companyId: event.companyId,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProductsByName(
      name: event.query,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onSearchByCompanyName(
    SearchProductsByCompanyName event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProductsByCompanyName(
      companyName: event.companyName,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onSearchByCategoryName(
    SearchProductsByCategoryName event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProductsByCategoryName(
      categoryName: event.categoryName,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onSearchByDescription(
    SearchProductsByDescription event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProductsByDescription(
      description: event.description,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onLoadProductsByCategoryId(
    LoadProductsByCategoryId event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());
    final res = await repository.getProductsByCategoryId(
      categoryId: event.categoryId,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onFilterProducts(
    FilterProducts event,
    Emitter<ProductsState> emit,
  ) async {
    await _handleEvent(event);
    emit(ProductsLoading());

    final res = await repository.filterProducts(
      orderByName: event.orderByName,
      orderByPrice: event.orderByPrice,
      orderByRate: event.orderByRate,
      fromRate: event.fromRate,
      toRate: event.toRate,
      fromPrice: event.fromPrice,
      toPrice: event.toPrice,
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );

    res.fold(
      (failure) => emit(ProductsError(failure.errMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }
}
