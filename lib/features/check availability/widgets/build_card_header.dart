import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/model/store.dart';

class buildCardHeader extends StatelessWidget {
  const buildCardHeader({
    super.key,
    required this.store,
    required this.context,
  });

  final Store store;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          store.name,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Chip(
          label: Text(
            '${store.distanceInKm} km',
            style: const TextStyle(
              color: AppColors.primaryDarkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppColors.accentGreen,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ],
    );
  }
}
