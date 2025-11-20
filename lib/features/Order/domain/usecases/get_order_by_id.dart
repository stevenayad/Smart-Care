import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderById {
  final OrderRepository repository;

  GetOrderById(this.repository);

  Future<Either<Failure, Orderr>> call(String id) async {
    return await repository.getOrderById(id);
  }
}
