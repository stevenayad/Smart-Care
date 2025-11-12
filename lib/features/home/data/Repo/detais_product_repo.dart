import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/favorite_item_model.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';

import 'package:smartcare/features/home/data/Model/favourite_model.dart';
import 'package:smartcare/features/home/data/Model/rate_input_request_update.dart';
import 'package:smartcare/features/home/data/Model/rate_model.dart';
import 'package:smartcare/features/home/data/Model/rateinputrequest.dart';

class DetaisProductRepo {
  final ApiConsumer api;

  DetaisProductRepo({required this.api});

  Future<Either<Failure, DetailsProductModel>> getdetailsproduct(
    String id,
  ) async {
    try {
      final response = await api.get("api/Products/${id}", null);
      print(
        '--------------------------------Details--------------------------------------------',
      );
      print(response);

      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = DetailsProductModel.fromJson(response);
      print(
        '-------------------- Parser Details-----------------------------------------',
      );
      print(parsedModel.data?.companyName);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, FavouriteModel>> addfavourite(String id) async {
    try {
      final response = await api.post(
        "api/favourites/add-to-my-favourites/${id}",
        null,
        false,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = FavouriteModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, FavouriteModel>> removefavourite(String id) async {
    try {
      final response = await api.delete(
        "api/favourites/remove-from-my-favourites/${id}",
        null,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = FavouriteModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, FavoriteItemModel>> getfavitem() async {
    try {
      final response = await api.get("api/me/favourites", null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = FavoriteItemModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, RateModel>> makerate(
    RateInputRequest rateinputrequest,
  ) async {
    try {
      final response = await api.post(
        "api/rates/create",
        rateinputrequest.toJson(),
        false,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = RateModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, RateModel>> updaterate(
    RateInputRequestUpdate rateinputrequestupdate,
  ) async {
    try {
      final response = await api.put(
        'api/rates/update',
        rateinputrequestupdate.toJson(),
      );

      final model = RateModel.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<String?> getExistingYourRate(String productId) async {
    try {
      final response = await api.get('api/me/rates', null);

      if (response == null ||
          response is! Map<String, dynamic> ||
          response['data'] == null) {
        return null;
      }

      final List<dynamic> dataList = response['data'];
      if (dataList.isEmpty) return null;
      for (final item in dataList) {
        if (item is Map<String, dynamic>) {
          final product = item['product'];
          if (product != null &&
              product['productId'] != null &&
              product['productId'].toString() == productId) {
            return item['id']?.toString();
          }
        }
      }

      return null;
    } on DioException catch (e) {
      print('❌ Dio error while checking existing rate: ${e.message}');
      return null;
    } catch (e) {
      print('❌ Unexpected error while checking existing rate: $e');
      return null;
    }
  }

  Future<Either<Failure, RateModel>> getUserRates() async {
    try {
      final response = await api.get('api/me/rates', null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final model = RateModel.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error"));
    }
  }
}
