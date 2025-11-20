import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/Order/data/datasources/order_remote_data_source.dart';
import 'package:smartcare/features/Order/data/models/order_model.dart';
import 'package:smartcare/features/Order/domain/entities/order.dart';
import 'package:smartcare/features/Order/domain/repositories/order_repository.dart';

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
  Future<Either<Failure, List<Orderr>>> getOrdersByCustomer(String clientId) async {
    try {
      final models = await remoteDataSource.getOrdersByCustomer(clientId);
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

  // --------------------------------------------------------------------------
  // CREATE ONLINE ORDER
  // --------------------------------------------------------------------------
  @override
  Future<Either<Failure, Orderr>> createOnlineOrder({
    required String cartId,
    required String deliveryAddressId,
  }) async {
    try {
      final model = await remoteDataSource.createOnlineOrder(
        cartId: cartId,
        deliveryAddressId: deliveryAddressId,
      );
      return Right(_fromModel(model));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  // --------------------------------------------------------------------------
  // CREATE PICKUP ORDER
  // --------------------------------------------------------------------------
  @override
  Future<Either<Failure, Orderr>> createPickupOrder({
    required String cartId,
    required String storeId,
  }) async {
    try {
      final model = await remoteDataSource.createPickupOrder(
        cartId: cartId,
        storeId: storeId,
      );
      return Right(_fromModel(model));
    } catch (e) {
      return Left(_handleError(e));
    }
  }
}
