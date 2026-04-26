import 'package:flutter/material.dart';
import 'package:smartcare/features/payment/presentation/views/widget/Button_model_sheet.dart';
import 'package:smartcare/features/payment/presentation/views/widget/list_view_model_sheet.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key, required this.orderid});
  final String orderid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        children: [
          const Text(
            "Select Payment Method",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListViewModelSheet(),
          ButtonModelSheet(orderid: orderid),
        ],
      ),
    );
  }
}
