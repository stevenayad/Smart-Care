import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/Orders/domain/entities/order.dart';
import 'order_status_badge.dart';

class OrderHeaderWidget extends StatelessWidget {
  final Orderr order;

  const OrderHeaderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.mediumGrey),
              ),
              OrderStatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '#${order.id.length > 8 ? order.id.substring(0, 8) : order.id}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryblue,
                ),
          ),
          const SizedBox(height: 12),
          if (order.createdAt != null)
            Row(
              children: [
                const Icon(Icons.access_time,
                    size: 16, color: AppColors.mediumGrey),
                const SizedBox(width: 6),
                Text(
                  DateFormat('MMM dd, yyyy • hh:mm a')
                      .format(order.createdAt!),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.mediumGrey),
                ),
              ],
            ),
        ],
      ),
    );
  }
}