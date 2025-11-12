import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/favorite_item_model.dart';

class Favrepoimplemtaion {
  final ApiConsumer api;

  Favrepoimplemtaion({required this.api});

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
}
