import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_state.dart';
import 'package:smartcare/core/widget/build_shimmer_box.dart';

class CompanyListView extends StatefulWidget {
  final Function(String) onCompanySelected;
  final String? selectedCompanyId;

  const CompanyListView({
    super.key,
    required this.onCompanySelected,
    this.selectedCompanyId,
  });

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginatedCompanyCubit, PaginatedCompanyState>(
      builder: (context, state) {
        if (state is PaginatedCompanyLoading && state.isFirstFetch) {
          return SizedBox(height: 160, child: buildCompanyShimmerList());
        }

        if (state is PaginatedCompanySuccess ||
            state is PaginatedCompanyLoading) {
          final companies = (state is PaginatedCompanySuccess)
              ? state.company
              : (state as PaginatedCompanyLoading).oldCompanies;
          final isLoadingMore =
              state is PaginatedCompanyLoading && !state.isFirstFetch;

          return Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF6F9FF), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200 &&
                    !context.read<PaginatedCompanyCubit>().isLoadingMore) {
                  context.read<PaginatedCompanyCubit>().fetchPaginatedCompany();
                }
                return false;
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: isLoadingMore
                    ? companies.length + 3
                    : companies.length,
                itemBuilder: (context, index) {
                  if (index >= companies.length) {
                    return buildCompanyShimmerCard();
                  }
                  final company = companies[index];
                  final isSelected = widget.selectedCompanyId == company.id;

                  return GestureDetector(
                    onTap: () => widget.onCompanySelected(company.id ?? ""),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(8),
                      width: 100,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            company.logoUrl ?? "https://via.placeholder.com/80",
                            height: 45,
                            width: 45,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            company.name ?? "Unknown",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
