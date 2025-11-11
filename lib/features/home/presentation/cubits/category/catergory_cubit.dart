import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/category_paginted_model/category_paginted_model.dart';
import 'package:smartcare/features/home/data/Model/catergory_model/catergory_model.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';

part 'catergory_state.dart';

class CatergoryCubit extends Cubit<GatergoryState> {
  CatergoryCubit(this.homerepo) : super(GatergoryInitial());
  final HomeRepo homerepo;

  Future<void> fetchGategory() async {
    emit(GatergroyLoading());
    try {
      print("🚀 About to call repo...");

      var result = await homerepo.getGategory();

      print("✨ Repository call finished successfully.");

      result.fold(
        (failure) {
          print("❌ Failure: ${failure.errMessage}");
          emit(GatergroyFaliure(errMessage: failure.errMessage));
        },
        (model) {
          emit(GatergroySucess(catergoryModel: model));
        },
      );
    } catch (e, s) {
      print("====================================");
      print("❌ 🚨 CRASH FOUND IN CUBIT CATCH BLOCK:");
      print("❌ Category parse error: $e");
      print(s);
      emit(GatergroyFaliure(errMessage: e.toString()));
    }
  }
}
