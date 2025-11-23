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
  
  FetchOrdersByCustomer();

  @override
  List<Object?> get props => [];
}

class FetchOrdersByCustomerAndStatus extends OrdersEvent {
  final String clientId;
  final int status;
  FetchOrdersByCustomerAndStatus(this.clientId, this.status);

  @override
  List<Object?> get props => [clientId, status];
}


