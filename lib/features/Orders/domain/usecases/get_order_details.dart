import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderDetails {
  final OrderRepository repository;

  GetOrderDetails(this.repository);

  Future<Either<Failure, Orderr>> call(String id) async {
    return await repository.getOrderDetails(id);
  }
}
