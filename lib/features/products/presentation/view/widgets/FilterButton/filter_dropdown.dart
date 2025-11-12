// import 'package:flutter/material.dart';
// import 'sort_section.dart';
// import 'price_range_section.dart';
// import 'rate_range_section.dart';
// import 'apply_filter_button.dart';

// class FilterDropdown extends StatefulWidget {
//   const FilterDropdown({super.key});

//   @override
//   State<FilterDropdown> createState() => _FilterDropdownState();
// }

// class _FilterDropdownState extends State<FilterDropdown> {
//   String selectedSort = 'Name A to Z';
//   final TextEditingController fromPrice = TextEditingController();
//   final TextEditingController toPrice = TextEditingController();
//   final TextEditingController fromRate = TextEditingController();
//   final TextEditingController toRate = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Container(
//       width: 300,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: colorScheme.primaryContainer.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SortSection(
//             selectedValue: selectedSort,
//             onChanged: (value) => setState(() => selectedSort = value),
//           ),
//           const SizedBox(height: 16),
//           PriceRangeSection(fromPrice: fromPrice, toPrice: toPrice),
//           const SizedBox(height: 16),
//           RateRangeSection(fromRate: fromRate, toRate: toRate),
//           const SizedBox(height: 16),
//           ApplyFilterButton(
//             selectedSort: selectedSort,
//             fromPrice: fromPrice,
//             toPrice: toPrice,
//             fromRate: fromRate,
//             toRate: toRate,
//           ),
//         ],
//       ),
//     );
//   }
// }
