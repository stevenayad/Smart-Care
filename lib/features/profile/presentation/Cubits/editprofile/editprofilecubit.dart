import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/profile/data/Model/input_model/edit_profile_request.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';

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

  bool isInitialized = false;

  int mapGender(String? gender) {
    switch (gender) {
      case 'Male':
        return 1;
      case 'Female':
        return 2;
      case 'NotPreferToSay':
      default:
        return 0;
    }
  }

  int mapAccountType(String? type) {
    switch (type) {
      case 'FamilyUse':
        return 1;
      case 'SelfUse':
      default:
        return 0;
    }
  }

  void initializeFromProfile(ProfileSuccess state) {
    if (isInitialized) return;

    final profile = state.model;

    firstNameController.text = profile.data?.firstName ?? '';
    lastNameController.text = profile.data?.lastName ?? '';
    usernameController.text = profile.data?.userName ?? '';
    phoneController.text = profile.data?.phoneNumber ?? '';
    dobController.text = profile.data?.birthDate ?? '';

    gender = mapGender(profile.data?.gender);
    accountType = mapAccountType(profile.data?.accountType);

    isInitialized = true;

    emit(EditProfileInitialized());
  }

  void setGender(int value) {
    gender = value;
    emit(EditProfileGenderChanged(gender));
  }

  void setAccountType(int value) {
    accountType = value;
    emit(EditProfileAccountTypeChanged(accountType));
  }

  DateTime getInitialDOB() {
    try {
      if (dobController.text.isNotEmpty) {
        final parts = dobController.text.split('/');
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (_) {}

    return DateTime(1990, 1, 1);
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
    usernameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    return super.close();
  }
}
