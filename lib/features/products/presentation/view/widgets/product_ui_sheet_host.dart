import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_event.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_state.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/view/widgets/FilterButton/filter_sheet.dart';
import 'package:smartcare/features/products/presentation/view/widgets/category_bottom_sheet.dart';
import 'package:smartcare/features/products/presentation/view/widgets/company_bottom_sheet.dart';

class ProductUiSheetHost extends StatelessWidget {
  final Widget child;

  const ProductUiSheetHost({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProductUiBloc, ProductUiState>(
          listenWhen: (previous, current) =>
              current.categorySheetSnap != null &&
              current.categorySheetNonce > previous.categorySheetNonce,
          listener: (context, state) async {
            final snap = state.categorySheetSnap!;
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (sheetContext) {
                return FractionallySizedBox(
                  heightFactor: 0.55,
                  child: CategoryBottomSheet(
                    selectedCategory: snap.selectedName,
                    categories: snap.categories,
                    onCategorySelected: (categoryName, categoryId) {
                      context.read<ProductsBloc>().add(
                        ProductCategorySelected(
                          displayName: categoryName,
                          categoryId: categoryId,
                        ),
                      );
                      Navigator.pop(sheetContext);
                    },
                  ),
                );
              },
            );
            if (!context.mounted) {
              return;
            }
            context.read<ProductUiBloc>().add(
              const ProductCategorySheetDismissed(),
            );
          },
        ),
        BlocListener<ProductUiBloc, ProductUiState>(
          listenWhen: (previous, current) =>
              current.companySheetSnap != null &&
              current.companySheetNonce > previous.companySheetNonce,
          listener: (context, state) async {
            final snap = state.companySheetSnap!;
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (sheetContext) {
                return FractionallySizedBox(
                  heightFactor: 0.55,
                  child: CompanyBottomSheet(
                    selectedCompany: snap.selectedName,
                    companies: snap.companies,
                    onCompanySelected: (companyName, companyId) {
                      context.read<ProductsBloc>().add(
                        ProductCompanySelected(
                          displayName: companyName,
                          companyId: companyId,
                        ),
                      );
                      Navigator.pop(sheetContext);
                    },
                  ),
                );
              },
            );
            if (!context.mounted) {
              return;
            }
            context.read<ProductUiBloc>().add(
              const ProductCompanySheetDismissed(),
            );
          },
        ),
        BlocListener<ProductUiBloc, ProductUiState>(
          listenWhen: (previous, current) =>
              current.filterSheetNonce > previous.filterSheetNonce,
          listener: (context, state) async {
            final productsBloc = context.read<ProductsBloc>();
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (sheetContext) {
                return BlocProvider.value(
                  value: productsBloc,
                  child: const FractionallySizedBox(
                    heightFactor: 0.7,
                    child: FilterSheet(),
                  ),
                );
              },
            );
            if (!context.mounted) {
              return;
            }
            context.read<ProductUiBloc>().add(
              const ProductFilterSheetDismissed(),
            );
          },
        ),
      ],
      child: child,
    );
  }
}
