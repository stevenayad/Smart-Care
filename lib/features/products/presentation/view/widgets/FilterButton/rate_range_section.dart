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
                  controller: fromRate,
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
                  controller: toRate,
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
