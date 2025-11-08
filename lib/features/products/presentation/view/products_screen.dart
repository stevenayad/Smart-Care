import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/companies/companies_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/companies/companies_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

import 'widgets/search_bar.dart';
import 'widgets/product_grid_widget.dart';
import 'widgets/chioces_row.dart';
import 'widgets/app_bar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentPage = 1;
  final int _pageSize = 10;

  void _loadPage(int page) {
    context.read<ProductsBloc>().add(
      LoadProducts(pageNumber: page, pageSize: _pageSize),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadPage(_currentPage);
    context.read<CompaniesBloc>().add(LoadCompanies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarr(),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadPage(_currentPage);
          context.read<CompaniesBloc>().add(LoadCompanies());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(),
                const SizedBox(height: 20),
                ChiocesRow(),
                const SizedBox(height: 20),

                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductsLoaded) {
                      return Column(
                        children: [
                          ProductGridWidget(products: state.products),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _currentPage > 1
                                    ? () {
                                        setState(() {
                                          _currentPage--;
                                        });
                                        _loadPage(_currentPage);
                                      }
                                    : null,
                                icon: const Icon(Icons.arrow_left),
                              ),
                              Text(
                                'Page $_currentPage',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: state.products.length == _pageSize
                                    ? () {
                                        setState(() {
                                          _currentPage++;
                                        });
                                        _loadPage(_currentPage);
                                      }
                                    : null,
                                icon: const Icon(Icons.arrow_right),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (state is ProductsError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
