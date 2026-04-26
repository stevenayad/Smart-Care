import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_event.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/gradient_button.dart';

class CompanyButton extends StatelessWidget {
  final String label;

  const CompanyButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SmallGradientButton(
      text: label,
      onTap: () =>
          context.read<ProductUiBloc>().add(const CompanyToolbarTapped()),
    );
  }
}
