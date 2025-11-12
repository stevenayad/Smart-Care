import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/favourite_model.dart';
import 'package:smartcare/features/home/data/Repo/detais_product_repo.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.detaisProductRepo) : super(FavouriteInitial());

  final DetaisProductRepo detaisProductRepo;
  final List<String> favouriteItems = [];
  Future<void> AddFavItem(String id) async {
    emit(Favouriteloading());
    final result = await detaisProductRepo.addfavourite(id);

    result.fold(
      (failure) {
        emit(FavouriteFailure(errmessage: failure.errMessage));
      },
      (model) {
        if (!favouriteItems.contains(id)) {
          favouriteItems.add(id);
        }
        emit(FavouriteSuccess(favouriteModel: model));
      },
    );
  }

  Future<void> RemoveFavItem(String id) async {
    emit(Favouriteloading());
    final result = await detaisProductRepo.removefavourite(id);
    result.fold(
      (failure) {
        emit(FavouriteFailure(errmessage: failure.errMessage));
      },
      (model) {
        favouriteItems.remove(id);
        emit(FavouriteSuccess(favouriteModel: model));
      },
    );
  }

  bool isFavourite(String productId) {
    return favouriteItems.contains(productId);
  }

  Future<void> toggleFavItem(String id) async {
    if (isFavourite(id)) {
      favouriteItems.remove(id);
      emit(FavouriteUpdated(favouriteItems: List.from(favouriteItems)));
      await RemoveFavItem(id);
    } else {
      favouriteItems.add(id);
      emit(FavouriteUpdated(favouriteItems: List.from(favouriteItems)));
      await AddFavItem(id);
    }
  }

  Future<void> loadFavouriteItems() async {
    emit(Favouriteloading());
    final result = await detaisProductRepo.getfavitem();
    result.fold(
      (failure) => emit(FavouriteFailure(errmessage: failure.errMessage)),
      (model) {
        favouriteItems.clear();
        favouriteItems.addAll(model.data?.map((e) => e.productId ?? '') ?? []);
        emit(FavouriteUpdated(favouriteItems: List.from(favouriteItems)));
      },
    );
  }
}

/*void toggleFavItem(String productId) {
    if (favouriteItems.contains(productId)) {
      favouriteItems.remove(productId);
    } else {
      favouriteItems.add(productId);
    }
    emit(FavouriteUpdated(favouriteItems: List.from(favouriteItems)));
  }*/
