import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/gradient_button.dart';
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
    return SizedBox(
      width: 120,
      child: SmallGradientButton(
        text: "Filter",
        icon: Icons.filter_alt_rounded,
        iconSize: 20,
        onTap: () => _openFilterSheet(context),
      ),
    );
  }
}
