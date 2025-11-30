import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';

class AddressRow extends StatelessWidget {
  final AddressModel address;
  const AddressRow({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade100,
          ),
          child: const Icon(Icons.location_on, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Text(
                address.address,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (address.isPrimary)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.greenAccent.shade100,
            ),
            child: Center(
              child: Text(
                'Default',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
      ],
    );
  }
}
