import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/profile/data/Model/condration_model/MedicalWarningResponse.dart';
import 'package:smartcare/features/profile/data/repo/semantic_search_repositoy.dart';

part 'contradication_state.dart';

class ContradicationCubit extends Cubit<ContradicationState> {
  ContradicationCubit({required this.repositoy})
    : super(ContradicationInitial());
  final SemanticSearchRepositoy repositoy;
  Future<void> getcondrationitem({required String id}) async {
    emit(ContradicationLoading());
    final response = await repositoy.getcondrationitem(id);
    response.fold(
      (failure) {
        emit(ContradicationError(message: failure.errMessage));
      },
      (items) {
        emit(ContradicationSuccess(medicalWarningResponse: items));
      },
    );
  }
}
