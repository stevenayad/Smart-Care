import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

import 'search_bar.dart';
import 'chioces_row.dart';
import 'product_grid_widget.dart';

class ProductsBody extends StatelessWidget {
  final int currentPage;
  final int pageSize;
  final void Function(BuildContext, int) onLoadPage;
  final VoidCallback onResetPage;

  const ProductsBody({
    super.key,
    required this.currentPage,
    required this.pageSize,
    required this.onLoadPage,
    required this.onResetPage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SearchBarWidget(),
            const SizedBox(height: 20),
            ChiocesRow(onResetPage: onResetPage),

            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductsLoaded) {
                  return Column(
                    children: [
                      ProductGridWidget(products: state.products),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: currentPage > 1
                                ? () => onLoadPage(context, currentPage - 1)
                                : null,
                            icon: const Icon(Icons.arrow_left),
                          ),
                          Text(
                            "Page $currentPage",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: state.products.length == pageSize
                                ? () => onLoadPage(context, currentPage + 1)
                                : null,
                            icon: const Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                if (state is ProductsError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
