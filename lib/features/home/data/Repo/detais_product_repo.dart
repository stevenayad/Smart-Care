import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/home/data/Model/detials_product_model/detials_product_model.dart';

class DetaisProductRepo {
  final ApiConsumer api;

  DetaisProductRepo({required this.api});

  Future<Either<Failure, DetialsProductModel>> getdetailsproduct(
    String id,
  ) async {
    try {
      final response = await api.get("api/user/Products?id=${id}", null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = DetialsProductModel.fromJson(response);
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
