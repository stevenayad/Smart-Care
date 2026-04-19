import 'package:equatable/equatable.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';
import 'package:smartcare/features/products/data/models/company_model.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';

enum ProductsListStatus { initial, loading, success, failure }

enum ProductsSideListStatus { initial, loading, success, failure }

enum ProductsSearchAxis { name, company, category, description }

class ProductsState extends Equatable {
  static const int defaultPageSize = 10;

  final ProductsListStatus productsStatus;
  final List<ProductModel> products;
  final String? productsError;

  final ProductsSideListStatus categoriesStatus;
  final List<CategoryModel> categories;
  final String? categoriesError;

  final ProductsSideListStatus companiesStatus;
  final List<CompanyModel> companies;
  final String? companiesError;

  final int currentPage;
  final int pageSize;

  final String selectedCategoryDisplayName;
  final String selectedCompanyDisplayName;

  final ProductsSearchAxis searchAxis;
  final String searchAxisLabel;
  final int productsContentVersion;

  const ProductsState({
    required this.productsStatus,
    required this.products,
    this.productsError,
    required this.categoriesStatus,
    required this.categories,
    this.categoriesError,
    required this.companiesStatus,
    required this.companies,
    this.companiesError,
    required this.currentPage,
    required this.pageSize,
    required this.selectedCategoryDisplayName,
    required this.selectedCompanyDisplayName,
    required this.searchAxis,
    required this.searchAxisLabel,
    required this.productsContentVersion,
  });

  factory ProductsState.initial() {
    return const ProductsState(
      productsStatus: ProductsListStatus.initial,
      products: [],
      categoriesStatus: ProductsSideListStatus.initial,
      categories: [],
      companiesStatus: ProductsSideListStatus.initial,
      companies: [],
      currentPage: 1,
      pageSize: defaultPageSize,
      selectedCategoryDisplayName: 'All',
      selectedCompanyDisplayName: 'All',
      searchAxis: ProductsSearchAxis.name,
      searchAxisLabel: 'Name',
      productsContentVersion: 0,
    );
  }

  ProductsState copyWith({
    ProductsListStatus? productsStatus,
    List<ProductModel>? products,
    String? productsError,
    ProductsSideListStatus? categoriesStatus,
    List<CategoryModel>? categories,
    String? categoriesError,
    ProductsSideListStatus? companiesStatus,
    List<CompanyModel>? companies,
    String? companiesError,
    int? currentPage,
    int? pageSize,
    String? selectedCategoryDisplayName,
    String? selectedCompanyDisplayName,
    ProductsSearchAxis? searchAxis,
    String? searchAxisLabel,
    int? productsContentVersion,
    bool clearProductsError = false,
    bool clearCategoriesError = false,
    bool clearCompaniesError = false,
  }) {
    return ProductsState(
      productsStatus: productsStatus ?? this.productsStatus,
      products: products ?? this.products,
      productsError: clearProductsError ? null : (productsError ?? this.productsError),
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categories: categories ?? this.categories,
      categoriesError: clearCategoriesError
          ? null
          : (categoriesError ?? this.categoriesError),
      companiesStatus: companiesStatus ?? this.companiesStatus,
      companies: companies ?? this.companies,
      companiesError: clearCompaniesError
          ? null
          : (companiesError ?? this.companiesError),
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      selectedCategoryDisplayName:
          selectedCategoryDisplayName ?? this.selectedCategoryDisplayName,
      selectedCompanyDisplayName:
          selectedCompanyDisplayName ?? this.selectedCompanyDisplayName,
      searchAxis: searchAxis ?? this.searchAxis,
      searchAxisLabel: searchAxisLabel ?? this.searchAxisLabel,
      productsContentVersion:
          productsContentVersion ?? this.productsContentVersion,
    );
  }

  @override
  List<Object?> get props => [
    productsStatus,
    products,
    productsError,
    categoriesStatus,
    categories,
    categoriesError,
    companiesStatus,
    companies,
    companiesError,
    currentPage,
    pageSize,
    selectedCategoryDisplayName,
    selectedCompanyDisplayName,
    searchAxis,
    searchAxisLabel,
    productsContentVersion,
  ];
}
