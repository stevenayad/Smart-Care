import 'package:flutter/material.dart';

class RateRangeSection extends StatelessWidget {
  final TextEditingController fromRate;
  final TextEditingController toRate;

  const RateRangeSection({
    super.key,
    required this.fromRate,
    required this.toRate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rate Range",
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
                controller: fromRate,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'From'),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextField(
                controller: toRate,
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
