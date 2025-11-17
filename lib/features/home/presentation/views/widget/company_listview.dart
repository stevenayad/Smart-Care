import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_state.dart';

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
          return SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 4,
              itemBuilder: (context, index) => Container(
                width: 90,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
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
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SizedBox(
              height: 80,
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: isLoadingMore
                      ? companies.length + 3
                      : companies.length,
                  itemBuilder: (context, index) {
                    if (index >= companies.length) {
                      return Container(
                        width: 90,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }

                    final company = companies[index];
                    final isSelected = widget.selectedCompanyId == company.id;

                    return GestureDetector(
                      onTap: () => widget.onCompanySelected(company.id ?? ""),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade700
                              : Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            company.name ?? "Unknown",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
