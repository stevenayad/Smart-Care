import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/model/store.dart';
import 'package:smartcare/features/check%20availability/widgets/store_card.dart';

class BodyCheckAvailablity extends StatelessWidget {
  const BodyCheckAvailablity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
          child: const Text(
            'Select a store to check product availability and reserve it for pickup',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              return StoreCard(store: stores[index]);
            },
          ),
        ),
      ],
    );
  }
}
