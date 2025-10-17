import 'package:flutter/material.dart';

class AddressRow extends StatelessWidget {
  const AddressRow({super.key, required this.address});
  final Map<String, dynamic> address;
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
          child: Icon(address['icon'], size: 20),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              address['type'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              address['name'],
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 8),
        if (address['isDefault'] == true) ...[
          Container(
            width: 50,
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
      ],
    );
  }
}
