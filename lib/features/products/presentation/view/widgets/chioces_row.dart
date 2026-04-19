import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_state.dart';
import 'package:smartcare/features/products/presentation/view/widgets/FilterButton/filter_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/category_button.dart';
import 'package:smartcare/features/products/presentation/view/widgets/company_button.dart';

class ChiocesRow extends StatelessWidget {
  const ChiocesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<ProductUiBloc, ProductUiState>(
        buildWhen: (previous, current) =>
            previous.categoryButtonLabel != current.categoryButtonLabel ||
            previous.companyButtonLabel != current.companyButtonLabel,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryButton(label: state.categoryButtonLabel),
              const SizedBox(width: 10),
              CompanyButton(label: state.companyButtonLabel),
              const SizedBox(width: 10),
              const FilterButton(),
            ],
          );
        },
      ),
    );
  }
}
