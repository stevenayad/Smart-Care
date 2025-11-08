import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/products/data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/company_model.dart';

abstract class ProductsRepository {
  Future<Either<servivefailure, List<ProductModel>>> getProducts({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> getProductsByCompanyId({
    required String companyId,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<ProductModel>>> searchProductsByName({
    required String name,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<servivefailure, List<CompanyModel>>> getCompanies();
  Future<Either<servivefailure, List<CategoryModel>>> getCategories();
  Future<Either<servivefailure, List<ProductModel>>> getProductsByCategoryId(String categoryId);


  Future<Either<servivefailure, List<ProductModel>>> searchProductsByCompanyName({
  required String companyName,
  int pageNumber = 1,
  int pageSize = 10,
});

Future<Either<servivefailure, List<ProductModel>>> searchProductsByCategoryName({
  required String categoryName,
  int pageNumber = 1,
  int pageSize = 10,
});

Future<Either<servivefailure, List<ProductModel>>> searchProductsByDescription({
  required String description,
  int pageNumber = 1,
  int pageSize = 10,
});

}
