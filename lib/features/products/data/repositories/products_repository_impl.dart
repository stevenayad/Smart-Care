import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import '../../data/models/product_model.dart';
import '../../data/models/company_model.dart';
import '../../data/models/category_model.dart';
import '../../data/datasources/products_remote_data_source.dart';
import '../../data/datasources/companies_remote_data_source.dart';
import '../../data/datasources/categories_remote_data_source.dart';

class ProductsRepositoryImpl {
  final ProductsRemoteDataSource productsRemoteDataSource;
  final CompaniesRemoteDataSource companiesRemoteDataSource;
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  ProductsRepositoryImpl(
    this.productsRemoteDataSource,
    this.companiesRemoteDataSource,
    this.categoriesRemoteDataSource,
  );

  // ---------------------------------------------------------------------------
  // 🧩 Helper: Safe universal parser for all product responses
  // ---------------------------------------------------------------------------
  List<ProductModel> _parseProducts(dynamic res) {
    if (res == null) return [];

    // Case 1: API returns a map with paginated items
    if (res is Map && res['data']?['items'] is List) {
      final items = res['data']['items'] as List;
      return _mapToProducts(items);
    }

    // Case 2: API returns a direct list inside "data"
    if (res is Map && res['data'] is List) {
      final items = res['data'] as List;
      return _mapToProducts(items);
    }

    // Case 3: API directly returns a list
    if (res is List) {
      return _mapToProducts(res);
    }
    final data = res['data'];

  // Case : Paginated response (data -> items -> list)
  if (data is Map && data['items'] is List) {
    final items = data['items'] as List;
    return _mapToProducts(items);
  }

  // Case : Direct list in "data"
  if (data is List) {
    return _mapToProducts(data);
  }

  // ✅ Case : Single product object
  if (data is Map) {
    return [ProductModel.fromJson(Map<String, dynamic>.from(data))];
  }

  // Case : Direct list at root (fallback)
  if (res is List) {
    return _mapToProducts(res);
  }
    // Case : Anything else
    return [];
  }

  List<ProductModel> _mapToProducts(List items) {
    return items
        .where((e) => e != null)
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // 🧩 PRODUCTS
  // ---------------------------------------------------------------------------

  Future<Either<Failure, List<ProductModel>>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.getProducts(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCompanyId({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.getProductsByCompanyId(
        companyId: companyId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryId(
    String categoryId,
  ) async {
    try {
      final res = await productsRemoteDataSource.getProductsByCategoryId(
        categoryId,
      );
      final products = _parseProducts(res); // ✅ uses unified parser
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByName({
    required String name,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.getProductsByName(
        name: name,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCompanyName({
    required String companyName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.getProductsByCompanyName(
        companyName: companyName,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryName({
    required String categoryName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.getProductsByCategoryName(
        categoryName: categoryName,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByDescription({
    required String description,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.getProductsByDescription(
        description: description,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> filterProducts({
    Map<String, dynamic>? body,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await productsRemoteDataSource.filterProducts(
        body: body,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // 🏢 COMPANIES
  // ---------------------------------------------------------------------------

  Future<Either<Failure, List<CompanyModel>>> getCompanies() async {
    try {
      final res = await companiesRemoteDataSource.getCompanies();
      final companies = res
          .where((e) => e != null)
          .map((e) => CompanyModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return Right(companies);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // 🗂️ CATEGORIES
  // ---------------------------------------------------------------------------

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final res = await categoriesRemoteDataSource.getCategories();
      final categories = res
          .where((e) => e != null)
          .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
}
