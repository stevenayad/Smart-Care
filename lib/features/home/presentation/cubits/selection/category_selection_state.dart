part of 'category_selection_cubit.dart';

class CategorySelectionState extends Equatable {
  final String? selectedCategoryId;

  const CategorySelectionState({this.selectedCategoryId});

  @override
  List<Object?> get props => [selectedCategoryId];
}

