import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/model/order_details/order_item..dart';
import 'package:smartcare/features/order/presentation/views/widget/order_summary_item.dart';

class OrderSummaryList extends StatelessWidget {
  final List<OrderItem> orderItems;

  const OrderSummaryList({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: orderItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return OrderSummaryItem(item: orderItems[index]);
      },
    );
  }
}
