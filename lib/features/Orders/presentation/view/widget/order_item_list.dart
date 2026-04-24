import 'package:flutter/material.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_item_widget.dart';

class OrderItemsList extends StatelessWidget {
  final dynamic order;

  const OrderItemsList({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: order.orderItems?.length ?? 0,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: OrderItemWidget(
              item: order.orderItems![index],
            ),
          );
        },
      ),
    );
  }
}