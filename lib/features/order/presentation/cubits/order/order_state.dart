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
  bool clearModels = false,
}) {
  return OrderState(
    hasActiveOrder: hasActiveOrder ?? this.hasActiveOrder,
    isLoading: isLoading ?? this.isLoading,
    errmessage: errmessage,

    pickupOrderModel:
        clearModels ? null : (pickupOrderModel ?? this.pickupOrderModel),

    createOrderModel:
        clearModels ? null : (createOrderModel ?? this.createOrderModel),

    updateordermodel:
        clearModels ? null : (updateordermodel ?? this.updateordermodel),

    orderDetails:
        clearModels ? null : (orderDetails ?? this.orderDetails),

    outodstock:
        clearModels ? null : (outodstock ?? this.outodstock),
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
