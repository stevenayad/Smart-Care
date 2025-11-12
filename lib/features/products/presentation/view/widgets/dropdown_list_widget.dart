// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
// import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';

// class DropdownListWidget extends StatefulWidget {
//   const DropdownListWidget({super.key});

//   @override
//   State<DropdownListWidget> createState() => _DropdownListWidgetState();
// }

// class _DropdownListWidgetState extends State<DropdownListWidget> {
//   final List<String> options = [
//     'Name A to Z',
//     'Name Z to A',
//     'Price: Low to High',
//     'Price: High to Low',
//     'Rate: Low to High',
//     'Rate: High to Low',
//   ];

//   String selectedValue = 'Name A to Z';

//   // Controllers for ranges
//   final TextEditingController fromPriceController = TextEditingController();
//   final TextEditingController toPriceController = TextEditingController();
//   final TextEditingController fromRateController = TextEditingController();
//   final TextEditingController toRateController = TextEditingController();

//   void _applyFilter(BuildContext context) {
//     bool? orderByName;
//     bool? orderByPrice;
//     bool? orderByRate;

//     switch (selectedValue) {
//       case 'Name A to Z':
//         orderByName = true;
//         break;
//       case 'Name Z to A':
//         orderByName = false;
//         break;
//       case 'Price: Low to High':
//         orderByPrice = true;
//         break;
//       case 'Price: High to Low':
//         orderByPrice = false;
//         break;
//       case 'Rate: Low to High':
//         orderByRate = true;
//         break;
//       case 'Rate: High to Low':
//         orderByRate = false;
//         break;
//     }

//     // Optional ranges
//     final double? fromPrice = double.tryParse(fromPriceController.text);
//     final double? toPrice = double.tryParse(toPriceController.text);
//     final double? fromRate = double.tryParse(fromRateController.text);
//     final double? toRate = double.tryParse(toRateController.text);

//     // Dispatch to Bloc
//     context.read<ProductsBloc>().add(
//           FilterProducts(
//             orderByName: orderByName,
//             orderByPrice: orderByPrice,
//             orderByRate: orderByRate,
//             fromPrice: fromPrice,
//             toPrice: toPrice,
//             fromRate: fromRate,
//             toRate: toRate,
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Container(
//       width: 300, // ✅ Fixed width to work in horizontal scroll
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: colorScheme.primaryContainer.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔽 Dropdown Filter
//           DecoratedBox(
//             decoration: BoxDecoration(
//               color: colorScheme.primaryContainer,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: selectedValue,
//                 icon: const Icon(Icons.arrow_drop_down),
//                 dropdownColor: colorScheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 items: options.map((String item) {
//                   final bool isSelected = item == selectedValue;
//                   return DropdownMenuItem<String>(
//                     value: item,
//                     child: Row(
//                       children: [
//                         if (isSelected)
//                           Icon(Icons.check,
//                               color: colorScheme.surface, size: 18),
//                         if (isSelected) const SizedBox(width: 6),
//                         Text(
//                           item,
//                           style: TextStyle(
//                             color: isSelected
//                                 ? colorScheme.surface
//                                 : colorScheme.onPrimary,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue == null) return;
//                   setState(() => selectedValue = newValue);
//                 },
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // 💰 Price Range Inputs
//           Text(
//             "Price Range",
//             style: TextStyle(
//               color: colorScheme.onPrimaryContainer,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),

//           // ✅ FIXED: Use Flexible instead of Expanded
//           SizedBox(
//             width: double.infinity,
//             child: Row(
//               children: [
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: TextField(
//                     controller: fromPriceController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'From',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: TextField(
//                     controller: toPriceController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'To',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           // ⭐ Rate Range Inputs
//           Text(
//             "Rate Range",
//             style: TextStyle(
//               color: colorScheme.onPrimaryContainer,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),

//           // ✅ FIXED: Same Flexible fix
//           SizedBox(
//             width: double.infinity,
//             child: Row(
//               children: [
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: TextField(
//                     controller: fromRateController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'From',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: TextField(
//                     controller: toRateController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'To',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // 🔘 Apply Filter Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () => _applyFilter(context),
//               icon: const Icon(Icons.filter_alt_rounded),
//               label: const Text('Apply Filter'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colorScheme.primary,
//                 foregroundColor: colorScheme.onPrimary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
