import 'package:bloc/bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/selection/company_selection_state.dart';

class CompanySelectionCubit extends Cubit<CompanySelectionState> {
  CompanySelectionCubit() : super(const CompanySelectionState());

  void selectCompany(String id) {
    final trimmed = id.trim();
    if (trimmed.isEmpty || trimmed == state.selectedCompanyId) return;
    emit(CompanySelectionState(selectedCompanyId: trimmed));
  }
}
