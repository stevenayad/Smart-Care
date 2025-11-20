import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchOrderById extends OrdersEvent {
  final String id;
  FetchOrderById(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchOrderDetails extends OrdersEvent {
  final String id;
  FetchOrderDetails(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchOrdersByCustomer extends OrdersEvent {
  final String clientId;
  FetchOrdersByCustomer(this.clientId);

  @override
  List<Object?> get props => [clientId];
}

class FetchOrdersByCustomerAndStatus extends OrdersEvent {
  final String clientId;
  final int status;
  FetchOrdersByCustomerAndStatus(this.clientId, this.status);

  @override
  List<Object?> get props => [clientId, status];
}

class CreateOnlineOrderEvent extends OrdersEvent {
  final String cartId;
  final String deliveryAddressId;
  CreateOnlineOrderEvent({required this.cartId, required this.deliveryAddressId});

  @override
  List<Object?> get props => [cartId, deliveryAddressId];
}

class CreatePickupOrderEvent extends OrdersEvent {
  final String cartId;
  final String storeId;
  CreatePickupOrderEvent({required this.cartId, required this.storeId});

  @override
  List<Object?> get props => [cartId, storeId];
}
