import 'package:flutter/material.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key, required this.address});
  final Map<String, dynamic> address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address['addressLine1'] + ',' + ' ' + address['addressLine2'],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 6),
        Text(
          address['city'] + ',' + '  ' + address['zipCode'],
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        Text(
          "+" + address['phone'],
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
