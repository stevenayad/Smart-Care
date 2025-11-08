import 'package:smartcare/features/profile/data/Model/profiledata/profiledata.dart';

abstract class Profilestate {
  const Profilestate();
  List<Object> get propos => [];
}

class ProfileIntial extends Profilestate {}

class Profilloading extends Profilestate {}

class ProfileFailure extends Profilestate {
  final String errMessage;
  const ProfileFailure({required this.errMessage});
}

class ProfileSuccess extends Profilestate {
  final Profiledata model;
  const ProfileSuccess(this.model);
}
