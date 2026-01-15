import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/Orders/domain/entities/order.dart';

class OrderTotalWidget extends StatelessWidget {
  final Orderr order;

  const OrderTotalWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryblue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryblue.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total Amount", style: Theme.of(context).textTheme.titleMedium),
          Text(
            "${order.totalPrice?.toStringAsFixed(2) ?? '0.00'}",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryblue,
            ),
          ),
        ],
      ),
    );
  }
}
