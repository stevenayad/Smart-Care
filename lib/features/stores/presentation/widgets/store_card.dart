import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/stores/presentation/widgets/info_row.dart';
import 'package:smartcare/features/stores/presentation/widgets/call_button.dart';
import 'package:smartcare/features/stores/presentation/widgets/directions_button.dart';

class StoreCard extends StatelessWidget {
  final dynamic store;

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
                    Icons.local_pharmacy,
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

            // InfoRow(icon: Icons.access_time_outlined, text: store.hours),
            const SizedBox(height: 8),

            Row(
              children: [
                DirectionsButton(
                  lat: store.latitude,
                  long: store.longitude,
                  // onPressed: () {},
                ),
                const SizedBox(width: 12),
                CallButton(
                  phoneNumber: store.phone,
                  // onPressed: () {}
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
