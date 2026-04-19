import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';
import 'package:smartcare/features/products/data/models/company_model.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';
import 'package:smartcare/features/products/data/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiConsumer consumer;

  ProductRepositoryImpl(this.consumer);

  List<ProductModel> _parseProducts(dynamic res) {
    if (res == null) return [];

    if (res is List) {
      return _mapToProducts(res);
    }

    if (res is Map) {
      if (res['data']?['items'] is List) {
        return _mapToProducts(res['data']['items'] as List);
      }
      if (res['data'] is List) {
        return _mapToProducts(res['data'] as List);
      }
      final data = res['data'];
      if (data is Map && data['items'] is List) {
        return _mapToProducts(data['items'] as List);
      }
      if (data is List) {
        return _mapToProducts(data);
      }
      if (data is Map) {
        return [ProductModel.fromJson(Map<String, dynamic>.from(data))];
      }
    }

    return [];
  }

  List<ProductModel> _mapToProducts(List items) {
    return items
        .where((e) => e != null)
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final query = {'pageNumber': pageNumber, 'pageSize': pageSize};
      final response = await consumer.get('/api/Products', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByCompanyId({
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
      final response = await consumer.get('/api/Products/CompanyId', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByCategoryId({
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
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByName({
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
      final response = await consumer.get('/api/Products/Name', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByCompanyName({
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
      final response = await consumer.get('/api/Products/CompanyName', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByCategoryName({
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
      final response = await consumer.get('/api/Products/CategoryName', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByDescription({
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
      final response = await consumer.get('/api/Products/Description', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> filterProducts({
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

      final response = await consumer.get('/api/Products/Filter', query);
      if (response == null) {
        return Left(servivefailure('Invalid server response'));
      }
      final products = _parseProducts(response);
      return Right(products);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<CompanyModel>>> getCompanies() async {
    try {
      final response = await consumer.get('/api/companies', null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure('Invalid server response'));
      }
      final res = response;
      if (res.containsKey('data')) {
        final data = res['data'];
        if (data is List) {
          return Right(
            data
                .map((e) => CompanyModel.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList(),
          );
        }
        if (data is Map && data.containsKey('items') && data['items'] is List) {
          final items = data['items'] as List;
          return Right(
            items
                .map((e) => CompanyModel.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList(),
          );
        }
      }
      return Right([]);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }

  @override
  Future<Either<servivefailure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await consumer.get('/api/categories', null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure('Invalid server response'));
      }
      final res = response;
      if (res.containsKey('data')) {
        final data = res['data'];
        if (data is List) {
          return Right(
            data
                .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList(),
          );
        }
        if (data is Map && data.containsKey('items') && data['items'] is List) {
          final items = data['items'] as List;
          return Right(
            items
                .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList(),
          );
        }
      }
      return Right([]);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print('❌ Unexpected Error: $e');
      return Left(servivefailure('Unexpected error, please try again'));
    }
  }
}
