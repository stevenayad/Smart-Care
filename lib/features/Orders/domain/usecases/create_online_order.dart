import 'package:dartz/dartz.dart';
import '../../../../core/faluire.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class CreateOnlineOrder {
  final OrderRepository repository;

  CreateOnlineOrder(this.repository);

  Future<Either<Failure, Orderr>> call({required String cartId, required String deliveryAddressId}) async {
    return await repository.createOnlineOrder(cartId: cartId, deliveryAddressId: deliveryAddressId);
  }
}
