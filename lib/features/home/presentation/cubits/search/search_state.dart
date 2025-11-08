part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchSucess extends SearchState {
  final List<SearchDatum> searchModel;

  SearchSucess({required this.searchModel});
}

class Searchfaliure extends SearchState {
  final String errMessage;

  Searchfaliure({required this.errMessage});
}

class Searchloading extends SearchState {}
