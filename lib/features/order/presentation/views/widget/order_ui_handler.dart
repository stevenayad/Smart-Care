import 'package:flutter/material.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/orderscreen.dart';
import 'package:smartcare/features/order/presentation/views/widget/show_daliog.dart';

class OrderUiHandler {
  static void handleOrderState(BuildContext context, OrderState state) {
    if (state is PickupSucess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              Orderscreen(orderId: state.pickupOrderModel.data!.id ?? ""),
        ),
      );
      return;
    }
    if (state is CreateorderSucess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              Orderscreen(orderId: state.createOrderModel.data!.id ?? ""),
        ),
      );
      return;
    }
    if (state is UpdateorderSucess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              Orderscreen(orderId: state.updateordermodel.data!.id ?? ""),
        ),
      );
      return;
    }
    if (state is OrderFailure) {
      OrderDialog.showFailed(context, state.errmessage);
      return;
    }
    if (state is OrderOutofStock) {
      OrderDialog.showOutOfStock(context, state.outodstock);
      return;
    }
  }
}
