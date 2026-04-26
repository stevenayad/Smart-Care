import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_state.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/category_selection_cubit.dart';

import 'category_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagintedCategoryCubit, PaginatedCategoryState>(
      builder: (context, state) {
        // 🔹 First Loading
        if (state is PaginatedCategoryLoading && state.isFirstFetch) {
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

        // 🔹 Success + Pagination
        if (state is PaginatedCategorySuccess ||
            state is PaginatedCategoryLoading) {
          final categories = (state is PaginatedCategorySuccess)
              ? state.category
              : (state as PaginatedCategoryLoading).oldCategory;

          final isLoadingMore =
              state is PaginatedCategoryLoading && !state.isFirstFetch;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 70,
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
                child:
                    BlocBuilder<CategorySelectionCubit, CategorySelectionState>(
                      builder: (context, selectionState) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          physics: const BouncingScrollPhysics(),
                          itemCount: isLoadingMore
                              ? categories.length + 3
                              : categories.length,
                          itemBuilder: (context, index) {
                            // 🔹 Loading more
                            if (index >= categories.length) {
                              return Container(
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              );
                            }

                            final category = categories[index];
                            final categoryId = (category.id ?? '').trim();

                            final isSelected =
                                selectionState.selectedCategoryId == categoryId;

                            return CategoryItem(
                              label: category.name ?? 'Unknown',
                              isSelected: isSelected,
                              onTap: () {
                                context
                                    .read<CategorySelectionCubit>()
                                    .selectCategory(categoryId);
                              },
                            );
                          },
                        );
                      },
                    ),
              ),
            ),
          );
        }

        // 🔴 Error (كان عندك bug هنا)
        if (state is PaginatedCompanyError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
