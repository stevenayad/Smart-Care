import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../models/order_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderModel>> getOrderById(String id);
  Future<Either<Failure, OrderModel>> getOrderDetails(String id);
  Future<Either<Failure, List<OrderModel>>> getOrdersByCustomer();
  Future<Either<Failure, List<OrderModel>>> getOrdersByCustomerAndStatus(
    String clientId,
    int status,
  );
}
