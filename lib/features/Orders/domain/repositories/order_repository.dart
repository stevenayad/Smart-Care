import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, Orderr>> getOrderById(String id);
  Future<Either<Failure, Orderr>> getOrderDetails(String id);
  Future<Either<Failure, List<Orderr>>> getOrdersByCustomer();
  Future<Either<Failure, List<Orderr>>> getOrdersByCustomerAndStatus(String clientId, int status);
  Future<Either<Failure, Orderr>> createOnlineOrder({required String cartId, required String deliveryAddressId});
  Future<Either<Failure, Orderr>> createPickupOrder({required String cartId, required String storeId});
}
