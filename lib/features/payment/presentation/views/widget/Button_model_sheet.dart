import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/show_daliog.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';

class ButtonModelSheet extends StatelessWidget {
  final String orderid;
  const ButtonModelSheet({super.key, required this.orderid});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentStripeSuccess || state is PaymentPaymobSuccess) {
          context.read<CartCubit>().clearCart();
          context.read<OrderCubit>().resetorderid();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreenView()),
          );
        } else if (state is PaymentCashSuccess) {
          OrderDialog.showSuccess(
            context,
            'Order Successful',
            onPressed: () {
              context.read<CartCubit>().clearCart();
              context.read<OrderCubit>().resetorderid();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreenView()),
              );
            },
          );
        } else if (state is PaymentFlaiure) {
          OrderDialog.showFailed(context, state.errmessage);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            final selectedIndex = context.read<PaymentCubit>().selectedIndex;
            if (selectedIndex == 0) {
              context.read<PaymentCubit>().processIntentPayment(orderid);
            } else {
              context.read<PaymentCubit>().processCashPayment(orderid);
            }
          },
          child: const Text("Payment"),
        ),
      ),
    );
  }
}
