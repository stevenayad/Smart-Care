part of 'order_cubit.dart';

class OrderState extends Equatable {
  final bool hasActiveOrder;
  final bool isLoading;
  final String? errmessage;
  final PickupOrderModel? pickupOrderModel;
  final CreateOrderModel? createOrderModel;
  final Updateorder? updateordermodel;
  final OrderDetails? orderDetails;
  final List<OutOfStock>? outodstock;

  const OrderState({
    this.hasActiveOrder = false,
    this.isLoading = false,
    this.errmessage,
    this.pickupOrderModel,
    this.createOrderModel,
    this.updateordermodel,
    this.orderDetails,
    this.outodstock,
  });

  OrderState copyWith({
    bool? hasActiveOrder,
    bool? isLoading,
    String? errmessage,
    PickupOrderModel? pickupOrderModel,
    CreateOrderModel? createOrderModel,
    Updateorder? updateordermodel,
    OrderDetails? orderDetails,
    List<OutOfStock>? outodstock,
  }) {
    return OrderState(
      hasActiveOrder: hasActiveOrder ?? this.hasActiveOrder,
      isLoading: isLoading ?? this.isLoading,
      errmessage: errmessage,
      pickupOrderModel: pickupOrderModel ?? this.pickupOrderModel,
      createOrderModel: createOrderModel ?? this.createOrderModel,
      updateordermodel: updateordermodel ?? this.updateordermodel,
      orderDetails: orderDetails ?? this.orderDetails,
      outodstock: outodstock ?? this.outodstock,
    );
  }

  @override
  List<Object?> get props => [
    hasActiveOrder,
    isLoading,
    errmessage,
    pickupOrderModel,
    createOrderModel,
    updateordermodel,
    orderDetails,
    outodstock,
  ];
}