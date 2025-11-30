part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// // A generic success state that can hold different types of data.
// class AuthSuccess<T> extends AuthState {
//   final T data;
//   AuthSuccess(this.data);
// }
class LoginSuccess extends AuthState {
  final LoginResponseModel loginData;
  LoginSuccess(this.loginData);
}

class RegisterSuccess extends AuthState {
  final RegisterResponseModel registerData;
  RegisterSuccess(this.registerData);
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}

class ResetCodeSentSuccess extends AuthState {
  final BaseBoolResponse response;
  ResetCodeSentSuccess(this.response);
}

class ResetCodeConfirmedSuccess extends AuthState {
  final BaseBoolResponse response;
  ResetCodeConfirmedSuccess(this.response);
}

class PasswordResetSuccess extends AuthState {
  final BaseBoolResponse response;
  PasswordResetSuccess(this.response);
}
