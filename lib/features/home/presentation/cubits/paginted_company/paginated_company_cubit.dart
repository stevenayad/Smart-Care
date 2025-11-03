import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/paginted_model/paginted_model.dart';
import 'package:smartcare/features/home/data/Model/paginted_model/item.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';

part 'paginated_company_state.dart';

class PaginatedCompanyCubit extends Cubit<PaginatedCompanyState> {
  final HomeRepo homeRepo;
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;

  List<Item> allCompanies = [];

  PaginatedCompanyCubit(this.homeRepo) : super(PaginatedCompanyInitial());

  Future<void> fetchPaginatedCompany({bool isRefresh = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (isRefresh) {
      page = 1;
      allCompanies.clear();
      hasMore = true;
      emit(PaginatedCompanyLoading());
    }

    final result = await homeRepo.getPaginatedCompanies(page);

    result.fold(
      (failure) =>
          emit(PaginatedCompanyFailure(errMessage: failure.errMessage)),
      (paginatedModel) {
        final newData = paginatedModel.data?.items ?? [];
        if (newData.isEmpty) {
          hasMore = false;
        } else {
          allCompanies.clear();
          allCompanies.addAll(newData);
          page++;
        }
        emit(PaginatedCompanySuccess(company: List.from(allCompanies)));
      },
    );
    isLoading = false;
  }
}
