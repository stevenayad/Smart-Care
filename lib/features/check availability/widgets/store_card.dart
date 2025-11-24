import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';
import 'package:smartcare/features/check%20availability/widgets/build_card_header.dart';
import 'package:smartcare/features/check%20availability/widgets/build_stock_status.dart';
import 'package:smartcare/features/check%20availability/widgets/info_line.dart';

class StoreCard extends StatelessWidget {
  final InventoryModel inventory;

  const StoreCard({super.key, required this.inventory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCardHeader(inventory: inventory, context: context),
            const SizedBox(height: 12),
            InfoLine(icon: Icons.location_on_outlined, text: inventory.address),
            InfoLine(icon: Icons.phone_outlined, text: inventory.phone),
            // InfoLine(icon: Icons.access_time, text: store.operatingHours),
            const SizedBox(height: 16),
            buildStockStatus(inventory: inventory, context: context),
          ],
        ),
      ),
    );
  }
}
