import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_state.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/company_selection_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/company_selection_state.dart';

import 'company_item.dart';

class CompanyListView extends StatelessWidget {
  const CompanyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginatedCompanyCubit, PaginatedCompanyState>(
      builder: (context, state) {
        // 🔹 First Loading (Skeleton)
        if (state is PaginatedCompanyLoading && state.isFirstFetch) {
          return SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          );
        }

        if (state is PaginatedCompanySuccess ||
            state is PaginatedCompanyLoading) {
          final companies = (state is PaginatedCompanySuccess)
              ? state.company
              : (state as PaginatedCompanyLoading).oldCompanies;

          final isLoadingMore =
              state is PaginatedCompanyLoading && !state.isFirstFetch;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 70,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent - 200 &&
                      !context.read<PaginatedCompanyCubit>().isLoadingMore) {
                    context
                        .read<PaginatedCompanyCubit>()
                        .fetchPaginatedCompany();
                  }
                  return false;
                },
                child:
                    BlocBuilder<CompanySelectionCubit, CompanySelectionState>(
                  builder: (context, selectionState) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const BouncingScrollPhysics(),
                      itemCount: isLoadingMore
                          ? companies.length + 3
                          : companies.length,
                      itemBuilder: (context, index) {
                        // 🔹 Loading more skeleton
                        if (index >= companies.length) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          );
                        }

                        final company = companies[index];
                        final companyId = (company.id ?? '').trim();

                        final isSelected =
                            selectionState.selectedCompanyId == companyId;

                        return CompanyItem(
                          label: company.name ?? 'Unknown',
                          isSelected: isSelected,
                          onTap: () => context
                              .read<CompanySelectionCubit>()
                              .selectCompany(companyId),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }


        if (state is PaginatedCompanyError) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Text(
              state.errMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}