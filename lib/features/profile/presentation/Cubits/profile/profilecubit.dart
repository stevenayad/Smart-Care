import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/data/Model/change_password_model.dart';
import 'package:smartcare/features/profile/data/Model/input_model/change_password_request.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';

class Profilecubit extends Cubit<Profilestate> {
  Profilecubit(this.repo) : super(ProfileIntial());

  final ProfileRepoimplemtation repo;

  Future<void> fetchProfiledata() async {
    emit(Profilloading());
    var result = await repo.getProfileData();
    result.fold(
      (Failure) {
        print('❌ Failed: ${Failure.errMessage}');
        emit(ProfileFailure(errMessage: Failure.errMessage));
      },
      (data) {
        print('✅ Success: ${data.toString()}');
        emit(ProfileSuccess(data));
      },
    );
  }

  Future<void> ChangePassword(
    ChangePasswordRequest ChangePasswordRequest,
  ) async {
    emit(Profilloading());
    var result = await repo.ChangePassword(ChangePasswordRequest);
    result.fold(
      (Failure) {
        emit(ProfileFailure(errMessage: Failure.errMessage));
      },
      (data) {
        emit(ChangePasswordSuccess(data));
      },
    );
  }

  Future<void> Logout() async {
    emit(Profilloading());
    var result = await repo.Logout();
    result.fold(
      (Failure) {
        emit(ProfileFailure(errMessage: Failure.errMessage));
      },
      (data) {
        emit(LogoutSuccess());
      },
    );
  }
}
