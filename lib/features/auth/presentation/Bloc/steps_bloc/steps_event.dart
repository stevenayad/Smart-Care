

import 'package:image_picker/image_picker.dart';


abstract class StepsEvent {}


class NextStepRequested extends StepsEvent {
  final int currentStep;
  
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String email;
  final String birthDate;
  final int? gender;
  final String password;
  final String confirmPassword;
  final XFile? profileImage;

  NextStepRequested({
    required this.currentStep,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.password,
    required this.confirmPassword,
    required this.profileImage,
    required this.userName,
    required this.phoneNumber
  });
}

class PreviousStepRequested extends StepsEvent {}