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
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(12),
              isExpanded: true,
              items: options.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) onChanged(newValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}
