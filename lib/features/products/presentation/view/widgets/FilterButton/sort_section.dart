import 'package:flutter/material.dart';

class SortSection extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const SortSection({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<String> options = [
      'Name A to Z',
      'Name Z to A',
      'Price: Low to High',
      'Price: High to Low',
      'Rate: Low to High',
      'Rate: High to Low',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sort by",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              icon: const Icon(Icons.arrow_drop_down_rounded, size: 28),
              borderRadius: BorderRadius.circular(16),
              isExpanded: true,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              items: options.map((item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) => value != null ? onChanged(value) : null,
            ),
          ),
        ),
      ],
    );
  }
}
