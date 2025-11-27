import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/faluire.dart';
import '../../data/models/product_model.dart';
import '../../data/models/company_model.dart';
import '../../data/models/category_model.dart';
import 'package:smartcare/core/api/api_consumer.dart';

class ProductsRepositoryImpl {
  final ApiConsumer consumer;

  ProductsRepositoryImpl(this.consumer);

  // -----------------------------
  // Extract backend error message
  // -----------------------------
  String _backendMessageFrom(DioException dioError) {
    try {
      final data = dioError.response?.data;

      // Expected backend format:
      // { statusCode: 424, succeeded: false, message: "...", errorsBag: null, data: null }
      if (data is Map &&
          data["message"] is String &&
          data["message"].trim().isNotEmpty) {
        return data["message"];
      }

      return "Server returned an unknown error.";
    } catch (_) {
      return "Failed to read server message.";
    }
  }

  // -----------------------------
  // Map any error into safe text
  // -----------------------------
  String _mapError(Object e) {
    if (e is DioException) {
      if (e.response != null) {
        return _backendMessageFrom(e);
      }
      return "Network error. Please try again.";
    }

    return "Unexpected internal error.";
  }

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
      final query = {'pageNumber': pageNumber, 'pageSize': pageSize};
      final res = await consumer.get('/api/Products', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCompanyId({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        'CompanyId': companyId,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      final res = await consumer.get('/api/Products/CompanyId', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryId({
    required String categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        'CategoryId': categoryId,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      final response = await consumer.get('/api/Products/CategoryId', query);

      if (response is Map && response.containsKey('data')) {
        final items = response['data']['items'];
        if (items is List) return Right(_mapToProducts(items));
      }
      return Right([]);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByName({
    required String name,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        'NameEn': name,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      final res = await consumer.get('/api/Products/Name', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCompanyName({
    required String companyName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        'CompanyName': companyName,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      final res = await consumer.get('/api/Products/CompanyName', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryName({
    required String categoryName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        'CategoryName': categoryName,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      final res = await consumer.get('/api/Products/CategoryName', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByDescription({
    required String description,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        'Description': description,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };
      final res = await consumer.get('/api/Products/Description', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  Future<Either<Failure, List<ProductModel>>> filterProducts({
    bool? orderByName,
    bool? orderByPrice,
    bool? orderByRate,
    double? fromRate,
    double? toRate,
    double? fromPrice,
    double? toPrice,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {
        if (orderByName != null) 'OrderByName': orderByName,
        if (orderByPrice != null) 'OrderByPrice': orderByPrice,
        if (orderByRate != null) 'OrderByRate': orderByRate,
        if (fromRate != null) 'FromRate': fromRate,
        if (toRate != null) 'ToRate': toRate,
        if (fromPrice != null) 'FromPrice': fromPrice,
        if (toPrice != null) 'ToPrice': toPrice,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };

      final res = await consumer.get('/api/Products/Filter', query);
      final products = _parseProducts(res);
      return Right(products);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // 🏢 COMPANIES
  // ---------------------------------------------------------------------------
  Future<Either<Failure, List<CompanyModel>>> getCompanies() async {
    try {
      final res = await consumer.get('/api/companies', null);

      if (res is Map && res.containsKey('data')) {
        final data = res['data'];
        if (data is List)
          return Right(
            data
                .map((e) => CompanyModel.fromJson(Map<String, dynamic>.from(e)))
                .toList(),
          );
        if (data is Map && data.containsKey('items') && data['items'] is List) {
          return Right(
            data['items']
                .map((e) => CompanyModel.fromJson(Map<String, dynamic>.from(e)))
                .toList(),
          );
        }
      }

      print('⚠️ Unexpected companies response format: $res');
      return Right([]);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // 🗂️ CATEGORIES
  // ---------------------------------------------------------------------------
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final res = await consumer.get('/api/categories', null);

      if (res is Map && res.containsKey('data')) {
        final data = res['data'];
        if (data is List)
          return Right(
            data
                .map(
                  (e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)),
                )
                .toList(),
          );
        if (data is Map && data.containsKey('items') && data['items'] is List) {
          return Right(
            data['items']
                .map(
                  (e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)),
                )
                .toList(),
          );
        }
      }

      print('⚠️ Unexpected categories response format: $res');
      return Right([]);
    } catch (e) {
      return Left(servivefailure(_mapError(e)));
    }
  }
}
