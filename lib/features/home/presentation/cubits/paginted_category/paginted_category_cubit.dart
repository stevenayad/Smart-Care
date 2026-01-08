import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/category_paginted_model/item.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/paginted_category/paginted_category_state.dart';

class PagintedCategoryCubit extends Cubit<PaginatedCategoryState> {
  final HomeRepo homeRepo;
  int page = 1;
  bool hasMore = true;
  bool isLoadingMore = false;
  PagintedCategoryCubit(this.homeRepo) : super(PaginatedCompanyInitial());

  Future<void> fetchPaginatedCategory({bool isRefresh = false}) async {
    if (isLoadingMore) return;
    if (!hasMore && !isRefresh) return;

    isLoadingMore = true;
    if (isRefresh) {
      page = 1;
      hasMore = true;
      emit(
        const PaginatedCategoryLoading(oldCompanies: [], isFirstFetch: true),
      );
    } else if (state is PaginatedCategorySuccess) {
      emit(
        PaginatedCategoryLoading(
          oldCompanies: (state as PaginatedCategorySuccess).category,
          isFirstFetch: false,
        ),
      );
    } else {
      emit(
        const PaginatedCategoryLoading(oldCompanies: [], isFirstFetch: true),
      );
    }

    final result = await homeRepo.getPaginatedCategroory(page);

    result.fold(
      (failure) {
        emit(PaginatedCompanyError(errMessage: failure.errMessage));
      },
      (newData) {
        final List<GategoryItem> newCompanies = List<GategoryItem>.from(
          newData.data?.items ?? <GategoryItem>[],
        );

        final List<GategoryItem> updatedList = [
          ...(state is PaginatedCategorySuccess
              ? (state as PaginatedCategorySuccess).category
              : (state is PaginatedCategoryLoading
                    ? (state as PaginatedCategoryLoading).oldCompanies
                    : <GategoryItem>[])),
          ...newCompanies,
        ];

        hasMore = newData.data?.hasNext ?? false;
        page++;

        emit(PaginatedCategorySuccess(category: updatedList));
      },
    );

    isLoadingMore = false;
  }
}
