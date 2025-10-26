import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart'; // Adjust path
import 'package:smartcare/features/stores/models/store_model.dart'; // Adjust path
import 'package:smartcare/features/stores/widgets/info_row.dart'; // Adjust path
import 'package:smartcare/features/stores/widgets/call_button.dart'; // Import new widget
import 'package:smartcare/features/stores/widgets/directions_button.dart'; // Import new widget

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: AppColors.accentGreen,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    store.icon,
                    color: AppColors.primaryblue,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    store.name,
                    style: textTheme.headlineLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            InfoRow(icon: Icons.location_on_outlined, text: store.address),
            InfoRow(icon: Icons.phone_outlined, text: store.phone),
            InfoRow(icon: Icons.access_time_outlined, text: store.hours),

            const SizedBox(height: 8),

            Row(
              children: [
                DirectionsButton(onPressed: () {}),
                const SizedBox(width: 12),
                CallButton(onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
