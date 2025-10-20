import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/data/Model/input_model/edit_profile_request.dart';
import 'package:smartcare/features/profile/data/Model/profile_model/profile_model.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';
import 'package:smartcare/features/profile/presentation/views/profile_screen.dart';

class Editprofilecubit extends Cubit<EditProfilestate> {
  Editprofilecubit(this.repo) : super(EditProfileIntial());

  final ProfileRepoimplemtation repo;
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController dobController = TextEditingController();

  Future<void> editprofile(EditProfileRequest editprofrile) async {
    emit(EditProfilloading());
    var result = await repo.Editprofile(editprofrile);
    result.fold(
      (Failure) {
        emit(EditProfileFailure(errMessage: Failure.errMessage));
      },
      (data) {
        emit(Editprofilesuccess(data));
      },
    );
  }

  void onSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final request = EditProfileRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: usernameController.text,
        phoneNumber: phoneController.text,
        birthDate: dobController.text,
        gender: 0,
        accountType: 1,
      );

      editprofile(request);
  
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before saving.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void onCancel(BuildContext context) => Navigator.pop(context);

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    return super.close();
  }
}
