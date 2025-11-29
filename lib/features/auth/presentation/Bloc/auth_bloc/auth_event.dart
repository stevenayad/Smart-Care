part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

class RegisterButtonPressed extends AuthEvent {
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String email;
  final String password;
  final String birthDate;
  final int gender;
  final XFile profileImage;
  final int accountType;
  final String address;
  final String addressLabel;
  final String? addressAdditionalInfo;
  final double addressLatitude;
  final double addressLongitude;
  final bool addressIsPrimary;

  RegisterButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.gender,
    required this.profileImage,
    required this.accountType,
    required this.address,
    required this.addressLabel,
    this.addressAdditionalInfo,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.addressIsPrimary,
  });
}

class SendResetCodeEvent extends AuthEvent {
  final String email;
  SendResetCodeEvent(this.email);
}

class ConfirmResetCodeEvent extends AuthEvent {
  final String email;
  final String code;
  ConfirmResetCodeEvent(this.email, this.code);
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;
  ResetPasswordEvent(this.email, this.newPassword);
}
