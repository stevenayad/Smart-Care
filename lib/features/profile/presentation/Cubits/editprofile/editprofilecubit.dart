import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/profile/data/Model/input_model/edit_profile_request.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';

class Editprofilecubit extends Cubit<EditProfilestate> {
  Editprofilecubit(this.repo) : super(EditProfileIntial());

  final ProfileRepoimplemtation repo;
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController dobController = TextEditingController();

  int gender = 0;
  int accountType = 0;

  void setGender(int value) {
    gender = value;
    emit(EditProfileGenderChanged(gender));
  }

  void setAccountType(int value) {
    accountType = value;
    emit(EditProfileAccountTypeChanged(accountType));
  }

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
        gender: gender,
        accountType: accountType,
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

  File? profileImage;

  void pickProfileImage(File image) {
    profileImage = image;
  }

  Future<void> updateProfileImage() async {
    if (profileImage == null) return;

    emit(EditProfileImageUploading());

    final result = await repo.changeProfileImage(profileImage!);

    result.fold(
      (failure) {
        emit(EditProfileImageUploadFailure(errMessage: failure.errMessage));
      },
      (profileData) {
        emit(EditProfileImageUploadSuccess(profileData));
      },
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (file != null) {
      pickProfileImage(File(file.path));
      emit(EditProfileImagePicked());
      await updateProfileImage();
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    return super.close();
  }
}
