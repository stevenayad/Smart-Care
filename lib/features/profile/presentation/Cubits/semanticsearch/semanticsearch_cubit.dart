import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/profile/data/Model/semantic_model/semantic_model.dart';
import 'package:smartcare/features/profile/data/Model/voice_semantic_search/datum.dart';
import 'package:smartcare/features/profile/data/repo/semantic_search_repositoy.dart';

part 'semanticsearch_state.dart';

class SemanticsearchCubit extends Cubit<SemanticsearchState> {
  SemanticsearchCubit({required this.searchRepositoy})
    : super(SemanticsearchInitial());

  final SemanticSearchRepositoy searchRepositoy;

  Future<void> getitems(String query) async {
    if (isClosed) return;
    emit(Semanticsearchloading());
    var result = await searchRepositoy.getitem(query);
    if (isClosed) return;
    result.fold(
      (Failure) {
        emit(SemanticsearchFailure(errMessage: Failure.errMessage));
      },
      (data) {
        emit(SemanticsearchSuccess(semanticModel: data));
      },
    );
  }

  Future<void> getitemsbyvoice(String file) async {
    if (isClosed) return;
    emit(Semanticsearchloading());
    var result = await searchRepositoy.uploadAudio(file);
    if (isClosed) return;
    result.fold(
      (Failure) {
        emit(VoiceSemanticsearchFailure(errMessage: Failure.errMessage));
      },
      (data) {
        emit(VoiceSemanticsearchSuccess(voiceSemanticSearch: data.data!));
      },
    );
  }
}
