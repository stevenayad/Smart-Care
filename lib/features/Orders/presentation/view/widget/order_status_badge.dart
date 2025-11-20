import 'package:flutter/material.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_status_helper.dart';

class OrderStatusBadge extends StatelessWidget {
  final int? status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final textColor = OrderStatusHelper.getStatusTextColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: OrderStatusHelper.getStatusColor(status),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            OrderStatusHelper.getStatusIcon(status),
            size: 14, 
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            OrderStatusHelper.getStatusText(status),
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}