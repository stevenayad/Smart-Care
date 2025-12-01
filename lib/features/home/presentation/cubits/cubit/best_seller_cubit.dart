import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/best_seller_model/best_seller_model.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';

part 'best_seller_state.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit(this.homeRepo) : super(BestSellerInitial());

  final HomeRepo homeRepo;
  Future<void> fetchBestSeller() async {
    emit(BestSellerLoading());
    try {
      var result = await homeRepo.getBestSeller();
      result.fold(
        (failure) {
          print("❌ Failure: ${failure.errMessage}");
          emit(BestSellerFailure(errMessage: failure.errMessage));
        },
        (model) {
          emit(BestSellerSuccess(bestSellerModel: model));
        },
      );
    } catch (e) {
      emit(BestSellerFailure(errMessage: e.toString()));
    }
  }
}
