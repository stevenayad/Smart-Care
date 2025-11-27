import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';

import 'package:smartcare/features/payment/data/Model/payment_model/payment_model.dart';

class PaymentRepo {
  final ApiConsumer apiConsumer;

  PaymentRepo({required this.apiConsumer});

  Future<Either<Failure, PaymentModel>> PaymentOrder(String idorder) async {
    try {
      final response = await apiConsumer.post(
        "api/Payments/process/${idorder}",
        null,
        false,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = PaymentModel.fromJson(response);
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
