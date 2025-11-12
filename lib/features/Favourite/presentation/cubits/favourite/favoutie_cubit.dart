import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/Favourite/data/Models/favorite_item_model/favorite_item_model.dart';
import 'package:smartcare/features/Favourite/data/favrepoimplemtaion.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';
import 'package:smartcare/features/home/presentation/cubits/favourite/favourite_cubit.dart';

part 'favoutie_state.dart';

class DisplayFavoutieCubit extends Cubit<DisplayFavoutieState> {
  DisplayFavoutieCubit(this.favrepoimplemtaion) : super(FavoutieInitial());

  final Favrepoimplemtaion favrepoimplemtaion;
  final List<String> favouriteItems = [];
  Future<void> getitmfav() async {
    emit(FavoutieLoading());
    final result = await favrepoimplemtaion.getfavitem();
    result.fold(
      (failure) => emit(FavoutieFaliuree(errmessage: failure.errMessage)),
      (model) => emit(FavoutieSuceesss(favoriteItemModel: model)),
    );
  }
}
