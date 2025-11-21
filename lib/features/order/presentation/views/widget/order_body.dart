import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_summary_section.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OrderSummarySection(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EvlutedButton(text: 'Processing Order', onTap: () {}),
          ),
        ],
      ),
    );
  }
}
