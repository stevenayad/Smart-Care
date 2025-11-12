import 'package:bloc/bloc.dart';
import 'package:smartcare/features/home/data/Model/paginted_model/item.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
import 'paginated_company_state.dart';

class PaginatedCompanyCubit extends Cubit<PaginatedCompanyState> {
  final HomeRepo homeRepo;
  int page = 1;
  bool hasMore = true;
  bool isLoadingMore = false;

  PaginatedCompanyCubit(this.homeRepo) : super(PaginatedCompanyInitial());

  Future<void> fetchPaginatedCompany({bool isRefresh = false}) async {
    if (isLoadingMore) return;
    if (!hasMore && !isRefresh) return;

    isLoadingMore = true;
    if (isRefresh) {
      page = 1;
      hasMore = true;
      emit(const PaginatedCompanyLoading(oldCompanies: [], isFirstFetch: true));
    } else if (state is PaginatedCompanySuccess) {
      emit(
        PaginatedCompanyLoading(
          oldCompanies: (state as PaginatedCompanySuccess).company,
          isFirstFetch: false,
        ),
      );
    } else {
      emit(const PaginatedCompanyLoading(oldCompanies: [], isFirstFetch: true));
    }

    final result = await homeRepo.getPaginatedCompanies(page);

    result.fold(
      (failure) {
        emit(PaginatedCompanyError(errMessage: failure.errMessage));
      },
      (newData) {
        final List<Item> newCompanies = List<Item>.from(
          newData.data?.items ?? <Item>[],
        );

        final List<Item> updatedList = [
          ...(state is PaginatedCompanySuccess
              ? (state as PaginatedCompanySuccess).company
              : (state is PaginatedCompanyLoading
                    ? (state as PaginatedCompanyLoading).oldCompanies
                    : <Item>[])),
          ...newCompanies,
        ];

        hasMore = newData.data?.hasNext ?? false;
        page++;

        emit(PaginatedCompanySuccess(company: updatedList));
      },
    );

    isLoadingMore = false;
  }
}
