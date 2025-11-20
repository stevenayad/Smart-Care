import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/Orders/data/datasources/order_remote_data_source.dart';
import 'package:smartcare/features/Orders/data/models/order_model.dart';
import 'package:smartcare/features/Orders/domain/entities/order.dart';
import 'package:smartcare/features/Orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});


  Orderr _fromModel(OrderModel model) {
    return Orderr(
      id: model.id,
      clientId: model.clientId,
      paymentId: model.paymentId,
      address: model.address,
      totalPrice: model.totalPrice,
      status: model.status,
      createdAt: model.createdAt,
      orderItems: model.orderItems,
      store: model.store,
      outOfStocks: model.outOfStocks,
    );
  }

  // -------------------------------
  // Error Mapper (NO CHANGE TO FAILURE FILE)
  // -------------------------------
  Failure _handleError(dynamic e) {
    if (e is DioException) {
      return servivefailure.fromDioError(e);
    }
    return servivefailure("Unexpected error occurred.");
  }

  // --------------------------------------------------------------------------
  // GET ORDER BY ID
  // --------------------------------------------------------------------------
  @override
  Future<Either<Failure, Orderr>> getOrderById(String id) async {
    try {
      final model = await remoteDataSource.getOrderById(id);
      return Right(_fromModel(model));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  // --------------------------------------------------------------------------
  // GET ORDER DETAILS
  // --------------------------------------------------------------------------
  @override
  Future<Either<Failure, Orderr>> getOrderDetails(String id) async {
    try {
      final model = await remoteDataSource.getOrderDetails(id);
      return Right(_fromModel(model));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  // --------------------------------------------------------------------------
  // GET ALL ORDERS FOR CUSTOMER
  // --------------------------------------------------------------------------
  @override
  Future<Either<Failure, List<Orderr>>> getOrdersByCustomer() async {
    try {
      final models = await remoteDataSource.getOrdersByCustomer();
      return Right(models.map(_fromModel).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  // --------------------------------------------------------------------------
  // GET ORDERS BY STATUS
  // --------------------------------------------------------------------------
  @override
  Future<Either<Failure, List<Orderr>>> getOrdersByCustomerAndStatus(
      String clientId,
      int status,
  ) async {
    try {
      final models =
          await remoteDataSource.getOrdersByCustomerAndStatus(clientId, status);
      return Right(models.map(_fromModel).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

}
