import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'filter_sheet.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  void _openFilterSheet(BuildContext context) {
    final productsBloc = context.read<ProductsBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: productsBloc,
          child: FractionallySizedBox(
            heightFactor: 0.7,
            child: const FilterSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _openFilterSheet(context),
      icon: const Icon(Icons.filter_alt_rounded, size: 22),
      label: const Text(
        'Filter',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
