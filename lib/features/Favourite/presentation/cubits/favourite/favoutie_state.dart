part of 'favoutie_cubit.dart';

sealed class DisplayFavoutieState extends Equatable {
  const DisplayFavoutieState();

  @override
  List<Object> get props => [];
}

final class FavoutieInitial extends DisplayFavoutieState {}

class FavoutieSuceesss extends DisplayFavoutieState {
  final FavoriteItemModel favoriteItemModel;
  FavoutieSuceesss({required this.favoriteItemModel});
}

class FavoutieFaliuree extends DisplayFavoutieState {
  final String errmessage;
  FavoutieFaliuree({required this.errmessage});
}

class FavoutieLoading extends DisplayFavoutieState {}
