import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:smartcare/core/app_color.dart';

import 'package:smartcare/core/api/dio_consumer.dart';

import 'package:smartcare/features/products/data/repositories/products_repository_impl.dart';

import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_state.dart';

import 'package:smartcare/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/category/category_event.dart';

import 'package:smartcare/features/products/presentation/bloc/companies/companies_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/companies/companies_event.dart';

import 'package:smartcare/features/products/presentation/view/widgets/products_body.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentPage = 1;
  final int _pageSize = 10;
  Type? _lastEventType;

  @override
  void initState() {
    super.initState();
    _lastEventType = LoadProducts;
  }

  void _loadPage(BuildContext context, int page) {
    final bloc = context.read<ProductsBloc>();
    final lastEvent = bloc.lastEvent;

    setState(() {
      _currentPage = page;
    });

    if (lastEvent is FilterProducts) {
      bloc.add(
        FilterProducts(
          orderByName: lastEvent.orderByName,
          orderByPrice: lastEvent.orderByPrice,
          orderByRate: lastEvent.orderByRate,
          fromRate: lastEvent.fromRate,
          toRate: lastEvent.toRate,
          fromPrice: lastEvent.fromPrice,
          toPrice: lastEvent.toPrice,
          pageNumber: page,
          pageSize: _pageSize,
        ),
      );
    } else if (lastEvent is LoadProductsByCategoryId) {
      bloc.add(LoadProductsByCategoryId(lastEvent.categoryId, page, _pageSize));
    } else if (lastEvent is LoadProductsByCompany) {
      bloc.add(LoadProductsByCompany(lastEvent.companyId, page, _pageSize));
    } else if (lastEvent is SearchProducts) {
      bloc.add(SearchProducts(lastEvent.query, page, _pageSize));
    } else if (lastEvent is SearchProductsByCompanyName) {
      bloc.add(
        SearchProductsByCompanyName(lastEvent.companyName, page, _pageSize),
      );
    } else if (lastEvent is SearchProductsByCategoryName) {
      bloc.add(
        SearchProductsByCategoryName(lastEvent.categoryName, page, _pageSize),
      );
    } else if (lastEvent is SearchProductsByDescription) {
      bloc.add(
        SearchProductsByDescription(lastEvent.description, page, _pageSize),
      );
    } else {
      bloc.add(LoadProducts(pageNumber: page, pageSize: _pageSize));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductsRepositoryImpl>(
      create: (_) {
        final dio = DioConsumer(Dio());

        return ProductsRepositoryImpl(dio);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsBloc(
              RepositoryProvider.of<ProductsRepositoryImpl>(context),
            )..add(const LoadProducts()),
          ),
          BlocProvider(
            create: (context) => CompaniesBloc(
              RepositoryProvider.of<ProductsRepositoryImpl>(context),
            )..add(LoadCompanies()),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
              RepositoryProvider.of<ProductsRepositoryImpl>(context),
            )..add(LoadCategories()),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.primaryblue.withValues(alpha: 0.7),
                AppColors.accentGreen.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: () async {
                _loadPage(context, _currentPage);
                context.read<CompaniesBloc>().add(LoadCompanies());
                context.read<CategoryBloc>().add(LoadCategories());
              },
              child: BlocListener<ProductsBloc, ProductsState>(
                listenWhen: (prev, curr) => curr is ProductsLoaded,
                listener: (context, state) {
                  final lastEvent = context.read<ProductsBloc>().lastEvent;

                  if (_lastEventType != lastEvent.runtimeType) {
                    setState(() {
                      _currentPage = 1;
                      _lastEventType = lastEvent.runtimeType;
                    });
                  }
                },
                child: Builder(
                  builder: (innerContext) {
                    return ProductsBody(
                      currentPage: _currentPage,
                      pageSize: _pageSize,
                      onLoadPage: (ctx, page) => _loadPage(ctx, page),
                      onResetPage: () {
                        setState(() {
                          _currentPage = 1;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
