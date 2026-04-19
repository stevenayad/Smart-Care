import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';
import 'package:smartcare/features/products/data/models/company_model.dart';
import 'package:smartcare/features/products/data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<servivefailure, List<ProductModel>>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByCompanyId({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByCategoryId({
    required String categoryId,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByName({
    required String name,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByCompanyName({
    required String companyName,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByCategoryName({
    required String categoryName,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByDescription({
    required String description,
    int pageNumber = 1,
    int pageSize = 10,
  });

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
  });

  Future<Either<servivefailure, List<CompanyModel>>> getCompanies();

  Future<Either<servivefailure, List<CategoryModel>>> getCategories();
}
