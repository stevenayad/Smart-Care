import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';

import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/Orders/data/models/order_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiConsumer apiConsumer;

  OrderRepositoryImpl({required this.apiConsumer});

  Failure _handleError(dynamic e) {
    if (e is DioException) {
      return servivefailure.fromDioError(e);
    }
    return servivefailure("Unexpected error occurred.");
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderById(String id) async {
    try {
      final response = await apiConsumer.get('/api/orders/$id', null);
      final data = response['data'] as Map<String, dynamic>;
      return Right(OrderModel.fromJson(data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderDetails(String id) async {
    try {
      final response = await apiConsumer.get('/api/orders/details/$id', null);
      final data = response['data'] as Map<String, dynamic>;
      return Right(OrderModel.fromJson(data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByCustomer() async {
    try {
      final response = await apiConsumer.get('/api/me/orders', null);
      final list = response['data'] as List<dynamic>;
      return Right(list.map((e) => OrderModel.fromJson(e)).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByCustomerAndStatus(
    String clientId,
    int status,
  ) async {
    try {
      final response = await apiConsumer.get(
        '/api/orders/by-customer-and-status',
        {'clientId': clientId, 'status': status},
      );
      final list = response['data'] as List<dynamic>;
      return Right(list.map((e) => OrderModel.fromJson(e)).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }
}
