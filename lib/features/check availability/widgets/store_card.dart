import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/model/store.dart';
import 'package:smartcare/features/check%20availability/widgets/build_card_header.dart';
import 'package:smartcare/features/check%20availability/widgets/build_stock_status.dart';
import 'package:smartcare/features/check%20availability/widgets/info_line.dart';


class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({super.key, required this.store});

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
            buildCardHeader(store: store, context: context),
            const SizedBox(height: 12),
            InfoLine(icon: Icons.location_on_outlined, text: store.address),
            InfoLine(icon: Icons.phone_outlined, text: store.phoneNumber),
            InfoLine(icon: Icons.access_time, text: store.operatingHours),
            const SizedBox(height: 16),
            buildStockStatus(store: store, context: context),
          ],
        ),
      ),
    );
  }

}
