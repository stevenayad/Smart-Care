import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_price_section.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_summary_section.dart';
import 'package:smartcare/features/payment/presentation/views/payment_view.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key, required this.orderid});
  final String orderid;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const OrderSummarySection(),
          const SizedBox(height: 16),
          const OrderPriceSection(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EvalutedButton(
              text: 'Processing Payment',
              onTap: () {
                showPaymentSheet(context, orderid);
              },
            ),
          ),
        ],
      ),
    );
  }
}
