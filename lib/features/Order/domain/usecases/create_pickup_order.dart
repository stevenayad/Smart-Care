import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class CreatePickupOrder {
  final OrderRepository repository;

  CreatePickupOrder(this.repository);

  Future<Either<Failure, Orderr>> call({required String cartId, required String storeId}) async {
    return await repository.createPickupOrder(cartId: cartId, storeId: storeId);
  }
}
