import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_state.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_company/paginated_company_state.dart';

class CategoryListview extends StatefulWidget {
  final Function(String) onCategoryoSelected;
  final String? selectedCategoryId;

  const CategoryListview({
    super.key,
    required this.onCategoryoSelected,
    this.selectedCategoryId,
  });

  @override
  State<CategoryListview> createState() => _CategoryListviewState();
}

class _CategoryListviewState extends State<CategoryListview> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagintedCategoryCubit, PaginatedCategoryState>(
      builder: (context, state) {
        if (state is PaginatedCategoryLoading && state.isFirstFetch) {
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

        if (state is PaginatedCategorySuccess ||
            state is PaginatedCategoryLoading) {
          final categories = (state is PaginatedCategorySuccess)
              ? state.category
              : (state as PaginatedCategoryLoading).oldCompanies;

          final isLoadingMore =
              state is PaginatedCategoryLoading && !state.isFirstFetch;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SizedBox(
              height: 80,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent - 200 &&
                      !context.read<PagintedCategoryCubit>().isLoadingMore) {
                    context
                        .read<PagintedCategoryCubit>()
                        .fetchPaginatedCategory();
                  }
                  return false;
                },
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const BouncingScrollPhysics(),
                  itemCount: isLoadingMore
                      ? categories.length + 3
                      : categories.length,
                  itemBuilder: (context, index) {
                    if (index >= categories.length) {
                      return Container(
                        width: 90,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }

                    final category = categories[index];
                    final isSelected = widget.selectedCategoryId == category.id;

                    return GestureDetector(
                      onTap: () =>
                          widget.onCategoryoSelected(category.id ?? ""),
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
                            category.name ?? "Unknown",
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
