import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/Category_listview.dart';
import 'package:smartcare/features/home/presentation/views/widget/category_category_gridview.dart';
import 'package:smartcare/features/home/presentation/views/widget/company_product_gridview.dart';
import 'package:smartcare/features/home/presentation/views/widget/company_listview.dart';

class CategoryWithProductsScreen extends StatefulWidget {
  const CategoryWithProductsScreen({super.key});

  @override
  State<CategoryWithProductsScreen> createState() =>
      _CategoryWithProductsScreenState();
}

class _CategoryWithProductsScreenState
    extends State<CategoryWithProductsScreen> {
  String? selectedCategoryId;

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
      ],
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'Category & Products',
          showBackButton: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CategoryListview(
                selectedCategoryId: selectedCategoryId,
                onCategoryoSelected: (id) {
                  setState(() {
                    selectedCategoryId = id;
                  });
                },
              ),
            ),
            const SliverToBoxAdapter(child: Divider(thickness: 1)),
            if (selectedCategoryId != null)
              SliverFillRemaining(
                child: CategoryProductGridview(categoryId: selectedCategoryId!),
              )
            else
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    "Select a company to view products",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
