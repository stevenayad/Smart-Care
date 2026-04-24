import 'package:equatable/equatable.dart';
import '../../data/models/order_model.dart';

abstract class OrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrderLoaded extends OrdersState {
  final OrderModel order;
  OrderLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrdersListLoaded extends OrdersState {
  final List<OrderModel> orders;
  OrdersListLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderCreated extends OrdersState {
  final OrderModel order;
  OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
