import 'package:bloc/bloc.dart';
import 'package:smartcare/features/products/data/repositories/products_repository_impl.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductsRepositoryImpl repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final res = await repository.getCategories();
    res.fold(
      (failure) => emit(CategoryError(failure.errMessage)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
