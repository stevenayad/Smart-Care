import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/cart/data/model/create_cart_model.dart';
import 'package:smartcare/features/order/data/model/create_order_model/create_order_model.dart';
import 'package:smartcare/features/order/data/model/order_details/order_details..dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/outof_stock.dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/pickup_order_model.dart';
import 'package:smartcare/features/order/data/model/request_createoreder.dart';
import 'package:smartcare/features/order/data/model/request_pickup.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderrepo) : super(OrderInitial());

  String? orderid;
  final Orderrepo orderrepo;
  Future<void> pickorder(RequestPickup request) async {
    emit(OrderLoading());
    final result = await orderrepo.pickuporder(request);
    result.fold(
      (failure) {
        if (failure.outOfStocks != null && failure.outOfStocks!.isNotEmpty) {
          emit(OrderOutofStock(outodstock: failure.outOfStocks!));
        } else {
       
          emit(OrderFailure(errmessage: failure.errMessage));
        }
      },
      (model) {
        orderid = model.data!.id;
        print('Order id  in Cubit---${orderid}');
        emit(PickupSucess(pickupOrderModel: model));
      },
    );
  }

  Future<void> createorder(RequestCreateoreder request) async {
    emit(OrderLoading());
    final result = await orderrepo.createorder(request);
    result.fold(
      (failure) => emit(OrderFailure(errmessage: failure.errMessage)),
      (model) {
        orderid = model.data!.id;
        emit(CreateorderSucess(createOrderModel: model));
      },
    );
  }

  Future<void> getorderdetails(String id) async {
    emit(OrderLoading());
    final result = await orderrepo.fetchOrderDetails(id);
    result.fold(
      (failure) => emit(OrderFailure(errmessage: failure.errMessage)),
      (model) => emit(orderdetailssuccess(orderDetails: model)),
    );
  }
}
