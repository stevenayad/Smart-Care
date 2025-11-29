import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/data/Model/AddressModel/address_model.dart';

class AddressDetails extends StatelessWidget {
  final AddressModel address;
  const AddressDetails({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address.additionalInfo,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 6),
        Text(
          'Lat: ${address.latitude.toStringAsFixed(5)}, Lng: ${address.longitude.toStringAsFixed(5)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
