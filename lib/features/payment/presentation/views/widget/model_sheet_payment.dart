import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide PaymentMethod;
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';

import 'package:smartcare/features/order/presentation/views/widget/show_daliog.dart';
import 'package:smartcare/features/payment/data/Model/payment_method.dart';
import 'package:smartcare/features/payment/data/repo/payment_servcies.dart';

import 'package:smartcare/features/payment/presentation/cubits/cubit/signalr_cubit.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/open_payment_link.dart';
import 'package:smartcare/features/payment/presentation/views/widget/payment_item.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key, required this.orderid});
  final String orderid;

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  int selectedIndex = 0;

  final List<PaymentMethod> methods = [
    PaymentMethod(
      name: "Mastercard •••• 8888",
      subtitle: "Expires 06/26",
      icon: Icons.credit_card,
    ),
    PaymentMethod(
      name: "Cash on Delivery",
      subtitle: "Pay when you receive",
      image: 'https://cdn-icons-png.flaticon.com/512/3523/3523887.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final signalRService = AppSignalRService(CacheHelper.getAccessToken()!);

    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45,
              height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const Text(
            "Select Payment Method",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: methods.length,
              itemBuilder: (context, index) {
                return PaymentItem(
                  method: methods[index].copyWith(
                    isSelected: selectedIndex == index,
                  ),
                  onTap: () => setState(() => selectedIndex = index),
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: BlocListener<PaymentCubit, PaymentState>(
              listener: (context, state) async {
                if (state is PaymentIntentReady) {
                  print('Client Secret1 ${state.clientSecret}');
                  try {
                    print('Client Secret2 ${state.clientSecret}');
                    await PaymentServcies.payOrder(state.clientSecret);
                    print('Payment Success');
                    context.read<CartCubit>().clearCart();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreenView()),
                    );
                  } on StripeException catch (e) {
                    print('Stripe cancelled: ${e.error.localizedMessage}');
                    OrderDialog.showFailed(context, "Payment was cancelled");
                  } catch (e) {
                    print('Unexpected error: $e');

                    OrderDialog.showFailed(
                      context,
                      "Payment failed, please try again",
                    );
                  }
                } else if (state is PaymentCashSuccess) {
                  OrderDialog.showSuccess(
                    context,
                    'Order Successful',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => MainScreenView()),
                      );
                      context.read<CartCubit>().clearCart();
                    },
                  );
                } else if (state is PaymentFlaiure) {
                  OrderDialog.showFailed(context, state.errmessage);
                }
              },
              child: ElevatedButton(
                onPressed: () async {
                  final paymentSignalRCubit = PaymentSignalRCubit(
                    signalRService: signalRService,
                  );
                  // await paymentSignalRCubit.startPaymentSession();
                  if (selectedIndex == 0) {
                    context.read<PaymentCubit>().ConfrimOrderIntent(
                      widget.orderid,
                    );
                  } else if (selectedIndex == 1) {
                    context.read<PaymentCubit>().ConfrimOrderCash(
                      widget.orderid,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Payment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
