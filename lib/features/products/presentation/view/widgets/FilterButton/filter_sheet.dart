import 'package:flutter/material.dart';
import 'sort_section.dart';
import 'price_range_section.dart';
import 'rate_range_section.dart';
import 'apply_filter_button.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  String selectedSort = 'Name A to Z';
  final TextEditingController fromPrice = TextEditingController();
  final TextEditingController toPrice = TextEditingController();
  final TextEditingController fromRate = TextEditingController();
  final TextEditingController toRate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Text(
                  "Filter Products",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SortSection(
                  selectedValue: selectedSort,
                  onChanged: (value) => setState(() => selectedSort = value),
                ),
                const SizedBox(height: 16),
                PriceRangeSection(fromPrice: fromPrice, toPrice: toPrice),
                const SizedBox(height: 16),
                RateRangeSection(fromRate: fromRate, toRate: toRate),
                const SizedBox(height: 24),

                ApplyFilterButton(
                  selectedSort: selectedSort,
                  fromPrice: fromPrice,
                  toPrice: toPrice,
                  fromRate: fromRate,
                  toRate: toRate,
                  onClose: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
