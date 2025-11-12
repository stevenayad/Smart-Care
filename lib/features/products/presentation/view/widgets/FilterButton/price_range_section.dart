import 'package:flutter/material.dart';

class PriceRangeSection extends StatelessWidget {
  final TextEditingController fromPrice;
  final TextEditingController toPrice;

  const PriceRangeSection({
    super.key,
    required this.fromPrice,
    required this.toPrice,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price Range",
          style: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: fromPrice,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'From'),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: toPrice,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'To'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
