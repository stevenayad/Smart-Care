import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/profile/data/Model/semantic_model/semantic_model.dart';
import 'package:smartcare/features/profile/data/repo/semantic_search_repositoy.dart';

part 'semanticsearch_state.dart';

class SemanticsearchCubit extends Cubit<SemanticsearchState> {
  SemanticsearchCubit({required this.searchRepositoy})
    : super(SemanticsearchInitial());

  final SemanticSearchRepositoy searchRepositoy;

  Future<void> getitems(String query) async {
    emit(Semanticsearchloading());
    var result = await searchRepositoy.getitem(query);
    result.fold(
      (Failure) {
        emit(SemanticsearchFailure(errMessage: Failure.errMessage));
      },
      (data) {
        emit(SemanticsearchSuccess(semanticModel: data));
      },
    );
  }
}
