import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/Orders/domain/entities/order.dart';
import 'order_status_badge.dart';

class OrderListCard extends StatelessWidget {
  final Orderr order;
  final VoidCallback? onTap;

  const OrderListCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt != null
        ? DateFormat('MMM dd, yyyy').format(order.createdAt!)
        : 'N/A';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Material(
        color: AppColors.primaryblue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        elevation: 0,

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  offset: const Offset(0, 4),
                  blurRadius: 15,
                  spreadRadius: -5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryblue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: AppColors.primaryblue,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.id.length > 8 ? order.id.substring(0, 8) : order.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: AppColors.mediumGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: const TextStyle(
                              color: AppColors.mediumGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${order.totalPrice?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(
                        color: AppColors.primaryblue,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Transform.scale(
                      scale: 0.9,
                      alignment: Alignment.centerRight,
                      child: OrderStatusBadge(status: order.status),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
