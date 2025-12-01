part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class PickupSucess extends OrderState {
  final PickupOrderModel pickupOrderModel;

  PickupSucess({required this.pickupOrderModel});
}

class CreateorderSucess extends OrderState {
  final CreateOrderModel createOrderModel;

  CreateorderSucess({required this.createOrderModel});
}

class orderdetailssuccess extends OrderState {
  final OrderDetails orderDetails;

  orderdetailssuccess({required this.orderDetails});
}

class OrderFailure extends OrderState {
  final String errmessage;

  OrderFailure({required this.errmessage});
}

class OrderOutofStock extends OrderState {
  final List<OutOfStock> outodstock;

  OrderOutofStock({required this.outodstock});
}

class OrderLoading extends OrderState {}
