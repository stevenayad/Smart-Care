import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/orderscreen.dart';
import 'package:smartcare/features/order/presentation/views/widget/show_daliog.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';

class OrderUiHandler {
  static void handleOrderState(BuildContext context, OrderState state) {
    if (state.pickupOrderModel != null) {
      context.read<Profilecubit>().fetchProfiledata();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Orderscreen(
            orderId: state.pickupOrderModel!.data!.id ?? "",
          ),
        ),
      );

      return;
    }

    if (state.createOrderModel != null) {
      context.read<Profilecubit>().fetchProfiledata();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Orderscreen(
            orderId: state.createOrderModel!.data!.id ?? "",
          ),
        ),
      );

      return;
    }

    if (state.updateordermodel != null) {
      context.read<Profilecubit>().fetchProfiledata();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Orderscreen(
            orderId: state.updateordermodel!.data!.id ?? "",
          ),
        ),
      );

      return;
    }

    if (state.errmessage != null) {
      OrderDialog.showFailed(
        context,
        state.errmessage!,
      );

      return;
    }

    if (state.outodstock != null &&
        state.outodstock!.isNotEmpty) {
      OrderDialog.showOutOfStock(
        context,
        state.outodstock!,
      );

      return;
    }
  }
}