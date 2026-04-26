part of 'authcubit_cubit.dart';

sealed class AuthcubitState extends Equatable {
  const AuthcubitState();

  @override
  List<Object> get props => [];
}

final class AuthcubitInitial extends AuthcubitState {}

class Authenticated extends AuthcubitState {}

class Unauthenticated extends AuthcubitState {}
