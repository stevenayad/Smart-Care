import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartcare/features/home/data/Model/company_model/company_model.dart';
import 'package:smartcare/features/home/data/Repo/home_repo.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit(this.homeRepo) : super(CompanyInitial());

  final HomeRepo homeRepo;

  Future<void> fetchcomapy() async {
    emit(Companyloading());
    try {
      print("🚀 About to call repo...");

      var result = await homeRepo.getcomapny();

      print("✨ Repository call finished successfully.");

      result.fold(
        (failure) {
          print("❌ Failure: ${failure.errMessage}");
          emit(Companyfaliure(errMessage: failure.errMessage));
        },
        (model) {
          print("✅ Success: ${model.data?.length ?? 0} categories");
          print(
            '---------------------------------------------------------------------------------------------------------------------------------------------',
          );
          emit(CompanySuccess(companyModel: model));
        },
      );
    } catch (e, s) {
      print("====================================");
      print("❌ 🚨 CRASH FOUND IN CUBIT CATCH BLOCK:");
      print("❌ Category parse error: $e");
      print(s);
      emit(Companyfaliure(errMessage: e.toString()));
    }
  }

  
}
