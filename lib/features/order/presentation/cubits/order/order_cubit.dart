import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/model/create_order_model/create_order_model.dart';
import 'package:smartcare/features/order/data/model/order_details/order_details..dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/outof_stock.dart';
import 'package:smartcare/features/order/data/model/pickup_order_model/pickup_order_model.dart';
import 'package:smartcare/features/order/data/model/request_createoreder.dart';
import 'package:smartcare/features/order/data/model/request_pickup.dart';
import 'package:smartcare/features/order/data/model/requestupdateorder.dart';
import 'package:smartcare/features/order/data/model/udateorder/udateorder.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy_factory.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderrepo, {required this.orderService})
    : super(const OrderState());

  final OrderService orderService;
  final Orderrepo orderrepo;

  String? orderid;

  Future<void> createOrderFromSelection({
    required BuildContext context,
    required int tab,
    required String cartId,
    String? addressId,
    String? storeId,
  }) async {
    await orderService.process(
      context: context,
      tab: tab,
      cubit: this,
      cartId: cartId,
      addressId: addressId,
      storeId: storeId,
    );
  }

  Future<void> createDeliveryOrder({
    required String cartId,
    required String addressId,
  }) {
    return createorder(
      RequestCreateoreder(cartId: cartId, deliveryAddressId: addressId),
    );
  }

  Future<void> createPickupOrder({
    required String cartId,
    required String storeId,
  }) {
    return pickorder(RequestPickup(cartId: cartId, storeId: storeId));
  }

  Future<void> updateOrderFromSelection({
    required String cartId,
    required int updatedOrderType,
    String? storeId,
    String? shippingAddressId,
    required String orderId,
  }) {
    return updateorder(
      RequestUpdateOrder(
        orderId: orderId,
        cartId: cartId,
        updatedOrderType: updatedOrderType,
        storeId: storeId,
        shippingAddressId: shippingAddressId,
      ),
    );
  }

  Future<void> pickorder(RequestPickup request) async {
    emit(state.copyWith(isLoading: true, errmessage: null, clearModels: true));

    final result = await orderrepo.pickuporder(request);

    result.fold(
      (failure) {
        if (failure.outOfStocks != null && failure.outOfStocks!.isNotEmpty) {
          emit(
            state.copyWith(isLoading: false, outodstock: failure.outOfStocks),
          );
        } else {
          emit(
            state.copyWith(isLoading: false, errmessage: failure.errMessage),
          );
        }
      },
      (model) {
        if (model.data != null) {
          orderid = model.data!.id;
        }

        emit(
          state.copyWith(
            isLoading: false,
            hasActiveOrder: true,
            pickupOrderModel: model,
            outodstock: [],
          ),
        );
      },
    );
  }

  Future<void> createorder(RequestCreateoreder request) async {
    emit(state.copyWith(isLoading: true, errmessage: null, clearModels: true));

    final result = await orderrepo.createorder(request);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errmessage: failure.errMessage));
      },
      (model) {
        if (model.data != null) {
          orderid = model.data!.id;
          print('model.data!.id ${orderid}');
        }

        emit(
          state.copyWith(
            isLoading: false,
            hasActiveOrder: true,
            createOrderModel: model,
          ),
        );
      },
    );
  }

  Future<void> updateorder(RequestUpdateOrder request) async {
    emit(state.copyWith(isLoading: true, errmessage: null, clearModels: true));

    final result = await orderrepo.updateorder(request);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errmessage: failure.errMessage));
      },
      (model) {
        if (model.data != null) {
          orderid = model.data!.id;
        }

        emit(
          state.copyWith(
            isLoading: false,
            hasActiveOrder: true,
            updateordermodel: model,
          ),
        );
      },
    );
    if (orderid != null) {
      await getorderdetails(orderid ?? "");
    }
  }

  Future<void> getorderdetails(String id) async {
    if (state.isLoading) return;
    if (state.orderDetails?.data?.id == id) return;
    emit(state.copyWith(isLoading: true, errmessage: null, clearModels: true));
    final result = await orderrepo.fetchOrderDetails(id);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errmessage: failure.errMessage));
      },
      (model) {
        emit(state.copyWith(isLoading: false, orderDetails: model));
      },
    );
  }

  void resetorderid() {
    print("========== RESET ORDER ==========");

    print("OLD ORDER ID => $orderid");

    orderid = null;

    emit(const OrderState());

    print("NEW ORDER ID => $orderid");
    print("STATE RESET DONE");
    /*emit(
    state.copyWith(
      hasActiveOrder: false,
      errmessage: null,
      outodstock: null,
      isLoading: false,
      pickupOrderModel: state.pickupOrderModel,
      createOrderModel: state.createOrderModel,
      updateordermodel: state.updateordermodel,
      orderDetails: state.orderDetails,
    ),
  );*/
  }
}
