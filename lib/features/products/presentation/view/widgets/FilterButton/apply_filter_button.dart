import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/gradient_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SmallGradientButton(
        text: 'Apply Filter',
        icon: Icons.check_rounded,
        iconSize: 22,
        onTap: () {
          context.read<ProductsBloc>().add(
            ApplyProductFiltersSubmitted(
              sortLabel: selectedSort,
              fromPriceText: fromPrice.text,
              toPriceText: toPrice.text,
              fromRateText: fromRate.text,
              toRateText: toRate.text,
            ),
          );
          onClose();
        },
      ),
    );
  }
}
