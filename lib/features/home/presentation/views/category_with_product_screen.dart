import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/views/widget/category_list_view.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/category_selection_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/category_products_section.dart' show CategoryProductsSection;


class CategoryWithProductsScreen extends StatelessWidget {
  const CategoryWithProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepo = HomeRepo(api: DioConsumer(Dio()));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PagintedCategoryCubit(homeRepo)..fetchPaginatedCategory(),
        ),
        BlocProvider(create: (_) => CatergoryCubit(homeRepo)),
        BlocProvider(create: (_) => CategorySelectionCubit()),
      ],
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'Category & Products',
          showBackButton: true,
        ),
        body: BlocListener<CategorySelectionCubit, CategorySelectionState>(
          listenWhen: (previous, current) =>
              previous.selectedCategoryId != current.selectedCategoryId,
          listener: (context, state) {
            final id = state.selectedCategoryId;
            if (id == null) return;
            context.read<CatergoryCubit>().loadFirstPage(id);
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: CategoryListView()),
              const SliverToBoxAdapter(child: Divider(thickness: 1)),
              SliverFillRemaining(
                child:
                    BlocBuilder<CategorySelectionCubit, CategorySelectionState>(
                      builder: (context, selectionState) {
                        if (selectionState.selectedCategoryId == null) {
                          return const Center(
                            child: Text(
                              'Select a category to view products',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }
                        return CategoryProductsSection();
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
