import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrdersByCustomerAndStatus {
  final OrderRepository repository;

  GetOrdersByCustomerAndStatus(this.repository);

  Future<Either<Failure, List<Orderr>>> call(String clientId, int status) async {
    return await repository.getOrdersByCustomerAndStatus(clientId, status);
  }
}
