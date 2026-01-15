import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';

class buildStockStatus extends StatelessWidget {
  const buildStockStatus({
    super.key,
    required this.inventory,
    required this.context,
  });

  final InventoryModel inventory;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final bool inStock = inventory.availableQuantity > 0;
    final Color statusColor = inStock ? const Color(0xFF2E7D32) : Colors.red;
    final String statusText = inStock
        ? 'In Stock (${inventory.availableQuantity} units)'
        : 'Out of Stock';

    return Row(
      children: [
        Icon(
          inStock ? Icons.check_circle : Icons.cancel,
          color: statusColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          statusText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        // if (inStock)
        //   ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       foregroundColor: AppColors.white,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        //     ),
        //     child: const Text('Add to Cart'),
        //   ),
      ],
    );
  }
}
