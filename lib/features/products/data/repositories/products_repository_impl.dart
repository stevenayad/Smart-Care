import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/products/data/datasources/categories_remote_data_source.dart';
import 'package:smartcare/features/products/data/datasources/companies_remote_data_source.dart';
import 'package:smartcare/features/products/data/datasources/products_remote_data_source.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';
import '../../domain/repositories/products_repository.dart';

import '../models/product_model.dart';
import '../models/company_model.dart';
import 'package:dio/dio.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remote;
  final CompaniesRemoteDataSource companiesRemote;
  final CategoriesRemoteDataSource categoriesRemote;
  ProductsRepositoryImpl(this.remote, this.companiesRemote, this.categoriesRemote);

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final Map<String, dynamic> res = await remote.getProducts(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final items = res['data']?['items'] as List? ?? [];
      final products = items
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(products);
    } on DioException catch (dioErr) {
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>> getProductsByCompanyId({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await remote.getProductsByCompanyId(
        companyId: companyId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final items = res['data']?['items'] as List? ?? [];
      final products = items
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(products);
    } on DioException catch (dioErr) {
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  
  @override
  Future<Either<servivefailure, List<ProductModel>>> searchProductsByName({
    required String name,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await remote.getProductsByName(
        name: name,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      final data = res['data'];

      if (data == null) return Right([]);

      if (data is Map<String, dynamic> && data['items'] is List) {
        final items = data['items'] as List;
        final products = items
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(products);
      } else if (data is List) {
        final products = data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(products);
      } else if (data is Map<String, dynamic>) {
        final product = ProductModel.fromJson(data);
        return Right([product]);
      } else {
        return Right([]);
      }
    } on DioException catch (dioErr) {
      final msg = dioErr.response?.data?['message']?.toString() ?? '';
      if (msg.toLowerCase().contains('product not found')) {
        return const Right([]);
      }

      // otherwise, forward as real failure
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>>
  searchProductsByCompanyName({
    required String companyName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await remote.getProductsByCompanyName(
        companyName: companyName,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      final data = res['data'];
      if (data is List) {
        final products = data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(products);
      } else if (data is Map<String, dynamic>) {
        return Right([ProductModel.fromJson(data)]);
      } else {
        return Right([]);
      }
    } on DioException catch (dioErr) {
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>>
  searchProductsByCategoryName({
    required String categoryName,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await remote.getProductsByCategoryName(
        categoryName: categoryName,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      final data = res['data'];
      if (data is List) {
        final products = data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(products);
      } else if (data is Map<String, dynamic>) {
        return Right([ProductModel.fromJson(data)]);
      } else {
        return Right([]);
      }
    } on DioException catch (dioErr) {
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  @override
  Future<Either<servivefailure, List<ProductModel>>>
  searchProductsByDescription({
    required String description,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final res = await remote.getProductsByDescription(
        description: description,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      final items = res['data']?['items'] as List? ?? [];
      final products = items
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(products);
    } on DioException catch (dioErr) {
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  @override
  Future<Either<servivefailure, List<CompanyModel>>> getCompanies() async {
    try {
      final list = await companiesRemote.getCompanies();
      final companies = list
          .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(companies);
    } on DioException catch (dioErr) {
      return Left(servivefailure.fromDioError(dioErr));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
  @override
Future<Either<servivefailure, List<CategoryModel>>> getCategories() async {
  try {
    final list = await categoriesRemote.getCategories();
    final categories = list
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return Right(categories);
  } on DioException catch (dioErr) {
    return Left(servivefailure.fromDioError(dioErr));
  } catch (e) {
    return Left(servivefailure(e.toString()));
  }
}
@override
Future<Either<servivefailure, List<ProductModel>>> getProductsByCategoryId(String categoryId) async {
  try {
    final list = await remote.getProductsByCategoryId(categoryId);

    final products = list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return Right(products);
  } on DioException catch (dioErr) {
    return Left(servivefailure.fromDioError(dioErr));
  } catch (e) {
    return Left(servivefailure(e.toString()));
  }
}

}
