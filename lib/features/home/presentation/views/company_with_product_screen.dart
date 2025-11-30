import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_gridview.dart';
import 'package:smartcare/features/home/presentation/views/widget/company_listview.dart';

class CompanyWithProductsScreen extends StatefulWidget {
  const CompanyWithProductsScreen({super.key});

  @override
  State<CompanyWithProductsScreen> createState() =>
      _CompanyWithProductsScreenState();
}

class _CompanyWithProductsScreenState extends State<CompanyWithProductsScreen> {
  String? selectedCompanyId;

  @override
  Widget build(BuildContext context) {
    final homeRepo = HomeRepo(api: DioConsumer(Dio()));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PaginatedCompanyCubit(homeRepo)..fetchPaginatedCompany(),
        ),
        BlocProvider(create: (_) => CompanyCubit(homeRepo)),
      ],
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'Companies & Products',
          showBackButton: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CompanyListView(
                selectedCompanyId: selectedCompanyId,
                onCompanySelected: (id) {
                  setState(() {
                    selectedCompanyId = id;
                  });
                },
              ),
            ),
            const SliverToBoxAdapter(child: Divider(thickness: 1)),
            if (selectedCompanyId != null)
              SliverFillRemaining(
                child: ProductGridView(companyId: selectedCompanyId!),
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
