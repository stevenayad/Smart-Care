import 'package:smartcare/features/profile/data/Model/profiledata/profiledata.dart';

abstract class EditProfilestate {
  const EditProfilestate();
  List<Object> get propos => [];
}

class EditProfileIntial extends EditProfilestate {}

class EditProfilloading extends EditProfilestate {}

class EditProfileFailure extends EditProfilestate {
  final String errMessage;
  const EditProfileFailure({required this.errMessage});
}

class Editprofilesuccess extends EditProfilestate {
  final Profiledata model;
  const Editprofilesuccess(this.model);
}

class EditProfileGenderChanged extends EditProfilestate {
  final int? gender;
  EditProfileGenderChanged(this.gender);
}

class EditProfileAccountTypeChanged extends EditProfilestate {
  final int? accountType;
  EditProfileAccountTypeChanged(this.accountType);
}

class EditProfileImagePicked extends EditProfilestate {}

class EditProfileImageUploading extends EditProfilestate {}

class EditProfileImageUploadSuccess extends EditProfilestate {
  final Profiledata profileData;
  EditProfileImageUploadSuccess(this.profileData);
}

class EditProfileImageUploadFailure extends EditProfilestate {
  final String errMessage;
  EditProfileImageUploadFailure({required this.errMessage});
}
