import 'package:flutter/material.dart';

class DropdownListWidget extends StatefulWidget {
  const DropdownListWidget({super.key});

  @override
  State<DropdownListWidget> createState() => _DropdownListWidgetState();
}

class _DropdownListWidgetState extends State<DropdownListWidget> {
  final List<String> options = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Top Rated',
  ];

  String selectedValue = 'Top Rated';

  @override
  Widget build(BuildContext context) {
    // final TextTheme=Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(Icons.arrow_drop_down),
          dropdownColor: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          items: options.map((String item) {
            final bool isSelected = item == selectedValue;
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (isSelected)
                      Icon(Icons.check, color: colorScheme.surface, size: 18),

                    if (isSelected) const SizedBox(width: 6),
                    Text(
                      item,
                      style: TextStyle(
                        color: isSelected
                            ? colorScheme.surface
                            : colorScheme.onPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
