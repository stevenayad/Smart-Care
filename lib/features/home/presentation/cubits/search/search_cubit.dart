import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/search_model/datum.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.homeRepo) : super(SearchInitial());

  final HomeRepo homeRepo;

  Future<void> searchCompany({required String name}) async {
    emit(Searchloading());
    var result = await homeRepo.searchcomapny(name: name);
    result.fold(
      (failure) {
        print("❌ Failure: ${failure.errMessage}");
        emit(Searchfaliure(errMessage: failure.errMessage));
      },
      (model) {
        final data = model.data ?? [];
        emit(SearchSucess(searchModel: List.from(data)));
      },
    );
  }
}
