import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/products/domain/repositories/products_repository.dart';
import 'package:smartcare/features/profile/data/repo/semantic_search_repositoy.dart';
import 'package:smartcare/features/profile/presentation/Cubits/simillar/simillarproduct_state.dart';

class SimilarProductsCubit extends Cubit<SimilarProductsState> {
  final SemanticSearchRepositoy  repo;

  SimilarProductsCubit(this.repo) : super(SimilarProductsInitial());

  Future<void> getSimilarProducts(String productId) async {
    emit(SimilarProductsLoading());

    final result = await repo.getsimillaritem(productId);

    result.fold(
      (failure) => emit(SimilarProductsFailure(failure.errMessage)),
      (products) => emit(SimilarProductsSuccess(products.data)),
    );
  }
}