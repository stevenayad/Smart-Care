import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_selection_state.dart';

class CategorySelectionCubit extends Cubit<CategorySelectionState> {
  CategorySelectionCubit() : super(const CategorySelectionState());

  void selectCategory(String id) {
    final trimmed = id.trim();
    if (trimmed.isEmpty || trimmed == state.selectedCategoryId) return;
    emit(CategorySelectionState(selectedCategoryId: trimmed));
  }
}
