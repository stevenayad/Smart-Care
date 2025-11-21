import 'package:flutter/material.dart';
import 'filter_sheet.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: const FilterSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _openFilterSheet(context),
      icon: const Icon(Icons.filter_alt_rounded),
      label: const Text('Filter'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
