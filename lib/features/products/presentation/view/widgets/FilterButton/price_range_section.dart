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
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: fromPrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'From',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: TextField(
                  controller: toPrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'To',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
