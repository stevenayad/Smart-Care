import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/order/data/model/address_model/address_model.dart';
import 'package:smartcare/features/order/data/model/create_order_model/create_order_model.dart';
import 'package:smartcare/features/order/data/model/order_details/order_details..dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/pickup_order_model.dart';
import 'package:smartcare/features/order/data/model/request_createoreder.dart';
import 'package:smartcare/features/order/data/model/request_pickup.dart';
import 'package:smartcare/features/order/data/model/store_model/store_model.dart';

class Orderrepo {
  final ApiConsumer apiConsumer;

  Orderrepo({required this.apiConsumer});

  Future<Either<Failure, StoreOrderModel>> getstore() async {
    try {
      final response = await apiConsumer.get("api/stores", null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = StoreOrderModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, AddressModel>> getaddress() async {
    try {
      final response = await apiConsumer.get("api/Client/addresses", null);
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = AddressModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, PickupOrderModel>> pickuporder(
    RequestPickup request,
  ) async {
    try {
      final response = await apiConsumer.post(
        "api/orders/create-pickup-order",
        request.toJson(),
        false,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = PickupOrderModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, CreateOrderModel>> createorder(
    RequestCreateoreder request,
  ) async {
    try {
      final response = await apiConsumer.post(
        "api/orders/create-online-order",
        request.toJson(),
        false,
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = CreateOrderModel.fromJson(response);
      return Right(parsedModel);
    } on DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

    Future<Either<Failure, OrderDetails>> fetchOrderDetails(
    String id,
  ) async {
    try {
      final response = await apiConsumer.get(
        "api/orders/details/${id}",
        null
      );
      if (response == null || response is! Map<String, dynamic>) {
        return Left(servivefailure("Invalid server response"));
      }
      final parsedModel = OrderDetails.fromJson(response);
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
