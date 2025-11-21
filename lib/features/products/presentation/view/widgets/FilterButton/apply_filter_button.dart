import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';

class ApplyFilterButton extends StatelessWidget {
  final String selectedSort;
  final TextEditingController fromPrice;
  final TextEditingController toPrice;
  final TextEditingController fromRate;
  final TextEditingController toRate;
  final VoidCallback onClose;

  const ApplyFilterButton({
    super.key,
    required this.selectedSort,
    required this.fromPrice,
    required this.toPrice,
    required this.fromRate,
    required this.toRate,
    required this.onClose,
  });

  void _apply(BuildContext context) {
    bool? orderByName;
    bool? orderByPrice;
    bool? orderByRate;

    switch (selectedSort) {
      case 'Name A to Z':
        orderByName = true;
        break;
      case 'Name Z to A':
        orderByName = false;
        break;
      case 'Price: Low to High':
        orderByPrice = true;
        break;
      case 'Price: High to Low':
        orderByPrice = false;
        break;
      case 'Rate: Low to High':
        orderByRate = true;
        break;
      case 'Rate: High to Low':
        orderByRate = false;
        break;
    }

    context.read<ProductsBloc>().add(
      FilterProducts(
        orderByName: orderByName,
        orderByPrice: orderByPrice,
        orderByRate: orderByRate,
        fromPrice: double.tryParse(fromPrice.text),
        toPrice: double.tryParse(toPrice.text),
        fromRate: double.tryParse(fromRate.text),
        toRate: double.tryParse(toRate.text),
      ),
    );

    onClose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _apply(context),
        icon: const Icon(Icons.check),
        label: const Text('Apply Filter'),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
