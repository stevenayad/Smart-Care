import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/company/company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/company_selection_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/company_selection_state.dart';
import 'package:smartcare/features/home/presentation/views/widget/company_list_view.dart';
import 'package:smartcare/features/home/presentation/views/widget/company_products_section.dart';

class CompanyWithProductsScreen extends StatelessWidget {
  const CompanyWithProductsScreen({super.key});

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
        BlocProvider(create: (_) => CompanySelectionCubit()),
      ],
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: 'Companies & Products',
          showBackButton: true,
        ),
        body: BlocListener<CompanySelectionCubit, CompanySelectionState>(
          listenWhen: (previous, current) =>
              previous.selectedCompanyId != current.selectedCompanyId,
          listener: (context, state) {
            final id = state.selectedCompanyId;
            if (id == null) return;
            context.read<CompanyCubit>().loadFirstPage(id);
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: CompanyListView()),
              const SliverToBoxAdapter(child: Divider(thickness: 1)),
              SliverFillRemaining(
                child:
                    BlocBuilder<CompanySelectionCubit, CompanySelectionState>(
                      builder: (context, selectionState) {
                        if (selectionState.selectedCompanyId == null) {
                          return const Center(
                            child: Text(
                              'Select a company to view products',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }
                        return const CompanyProductsSection();
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
