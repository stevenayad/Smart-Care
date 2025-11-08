import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/home/data/Model/category_paginted_model/category_paginted_model.dart';
import 'package:smartcare/features/home/data/Model/catergory_model/catergory_model.dart';
import 'package:smartcare/features/home/data/Model/company_model/company_model.dart';
import 'package:smartcare/features/home/data/Model/paginted_model/paginted_model.dart';
import 'package:smartcare/features/home/data/Model/search_model/search_model.dart';

class HomeRepo {
  final ApiConsumer api;

  HomeRepo({required this.api});

  Future<Either<Failure, CategoryPagintedModel>> getGategory() async {
    print('ASSSSSSS');
    try {
      print("FFFFFFFFFFFFffffffff");
      final response = await api.get(
        "api/categories/paginated?pageNumber=1&pageSize=10",
        null,
      );
      print("🌐 Response runtimeType: ${response.runtimeType}");
      print("🌐 Response content: $response");

      final parsedModel = CategoryPagintedModel.fromJson(response);

      print("✅ Parsed model successfully!");
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, PagintedModel>> getcomapny() async {
    try {
      final response = await api.get(
        "api/companies/paginated?pageNumber=1&pageSize=10",
        null,
      );

      final parsedModel = PagintedModel.fromJson(response);

      return Right(parsedModel);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, SearchModel>> searchcomapny({
    required String name,
  }) async {
    try {
      final response = await api.get("api/companies/search?name=${name}", null);
      final parsedModel = SearchModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, PagintedModel>> getPaginatedCompanies(
    int pageNumber,
  ) async {
    try {
      final response = await api.get(
        "api/companies/paginated?pageNumber=$pageNumber&pageSize=100",
        null,
      );
      final parsedModel = PagintedModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }
}
