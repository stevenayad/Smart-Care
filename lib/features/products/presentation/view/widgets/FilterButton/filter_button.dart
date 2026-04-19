import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_event.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/gradient_button.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: SmallGradientButton(
        text: 'Filter',
        icon: Icons.filter_alt_rounded,
        iconSize: 20,
        onTap: () => context.read<ProductUiBloc>().add(const FilterToolbarTapped()),
      ),
    );
  }
}
