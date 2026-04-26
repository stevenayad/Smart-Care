import 'package:smartcare/features/profile/data/Model/simillar_search/datum.dart';

abstract class SimilarProductsState {}

class SimilarProductsInitial extends SimilarProductsState {}

class SimilarProductsLoading extends SimilarProductsState {}

class SimilarProductsSuccess extends SimilarProductsState {
  List<SimillarDatum>? products;

  SimilarProductsSuccess(this.products);
}

class SimilarProductsFailure extends SimilarProductsState {
  final String error;

  SimilarProductsFailure(this.error);
}
