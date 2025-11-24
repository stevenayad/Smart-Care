import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrdersByCustomer {
  final OrderRepository repository;

  GetOrdersByCustomer(this.repository);

  Future<Either<Failure, List<Orderr>>> call() async {
    return await repository.getOrdersByCustomer();
  }
}
