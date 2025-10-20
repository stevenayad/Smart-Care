
import 'package:smartcare/features/profile/data/Model/profile_model/profile_model.dart';

abstract class EditProfilestate {
  const EditProfilestate();
   List<Object> get propos => [];
}

 class  EditProfileIntial extends EditProfilestate {}
 class  EditProfilloading extends EditProfilestate {}
 class  EditProfileFailure extends EditProfilestate {
   final String errMessage;
   const EditProfileFailure({required this.errMessage});
 }

class  Editprofilesuccess extends  EditProfilestate{
   final ProfileModel model;
  const Editprofilesuccess(this.model);
}