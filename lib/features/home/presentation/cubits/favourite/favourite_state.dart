part of 'favourite_cubit.dart';

sealed class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

final class FavouriteInitial extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  final FavouriteModel favouriteModel;

  FavouriteSuccess({required this.favouriteModel});
}

class FavouriteFailure extends FavouriteState {
  final String errmessage;

  FavouriteFailure({required this.errmessage});
}

class Favouriteloading extends FavouriteState {}

class FavouriteUpdated extends FavouriteState {
  final List<String> favouriteItems;

  FavouriteUpdated({required this.favouriteItems});
}
