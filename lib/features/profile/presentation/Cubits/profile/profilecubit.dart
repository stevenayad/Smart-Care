import 'package:flutter_bloc/flutter_bloc.dart';
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
}
