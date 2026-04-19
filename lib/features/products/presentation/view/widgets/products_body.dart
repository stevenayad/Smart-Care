import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

import 'search_bar.dart';
import 'chioces_row.dart';
import 'product_grid_widget.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

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
            const ChiocesRow(),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state.productsStatus == ProductsListStatus.initial ||
                    state.productsStatus == ProductsListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.productsStatus == ProductsListStatus.success) {
                  return Column(
                    children: [
                      ProductGridWidget(products: state.products),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: state.currentPage > 1
                                ? () => context.read<ProductsBloc>().add(
                                    ProductPageRequested(state.currentPage - 1),
                                  )
                                : null,
                            icon: const Icon(Icons.arrow_left),
                          ),
                          Text(
                            'Page ${state.currentPage}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed:
                                state.products.length == state.pageSize
                                ? () => context.read<ProductsBloc>().add(
                                    ProductPageRequested(state.currentPage + 1),
                                  )
                                : null,
                            icon: const Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                if (state.productsStatus == ProductsListStatus.failure) {
                  return Center(
                    child: Text(state.productsError ?? 'Unknown error'),
                  );
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
