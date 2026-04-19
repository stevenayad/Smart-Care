import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/products/data/repository/product_repository.dart';
import 'package:smartcare/features/products/data/repository/product_repository_impl.dart';
import 'package:smartcare/features/products/presentation/bloc/product_ui/product_ui_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:smartcare/features/products/presentation/bloc/products/products_event.dart';
import 'package:smartcare/features/products/presentation/view/widgets/product_ui_sheet_host.dart';
import 'package:smartcare/features/products/presentation/view/widgets/products_body.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductRepository>(
      create: (_) => ProductRepositoryImpl(DioConsumer(Dio())),
      child: BlocProvider(
        create: (context) => ProductsBloc(
          RepositoryProvider.of<ProductRepository>(context),
        )..add(const ProductsStarted()),
        child: BlocProvider(
          create: (context) =>
              ProductUiBloc(context.read<ProductsBloc>()),
          child: ProductUiSheetHost(
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
                body: Builder(
                  builder: (innerContext) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        final bloc = innerContext.read<ProductsBloc>();
                        final version = bloc.state.productsContentVersion;
                        bloc.add(const ProductsRefreshRequested());
                        await bloc.stream.firstWhere(
                          (s) => s.productsContentVersion > version,
                        );
                      },
                      child: const ProductsBody(),
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
