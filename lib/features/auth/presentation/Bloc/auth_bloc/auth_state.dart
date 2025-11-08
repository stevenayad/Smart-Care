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

// NEW: A specific success state for a successful registration.
// It holds the RegisterResponseModel directly.
class RegisterSuccess extends AuthState {
  final RegisterResponseModel registerData;
  RegisterSuccess(this.registerData);
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}
