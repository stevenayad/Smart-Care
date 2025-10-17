// file: features/auth/presentation/bloc/auth_bloc.dart

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:smartcare/features/auth/data/AuthRep/auth_repository.dart';
import 'package:smartcare/features/auth/data/Model/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _authRepository.login(event.email, event.password);
    result.fold(
      (failure) => emit(AuthFailure(failure.errMessage)),
      (loginResponse) => emit(LoginSuccess(loginResponse)),
    );
  }

  void _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _authRepository.register(
      firstName: event.firstName,
      lastName: event.lastName,
      userName: event.userName,
      phoneNumber: event.phoneNumber,
      email: event.email,
      password: event.password,
      birthDate: event.birthDate,
      gender: event.gender,
      profileImage: event.profileImage,
      accountType: event.accountType,
      address: event.address,
      addressLabel: event.addressLabel,
      addressAdditionalInfo: event.addressAdditionalInfo,
      addressLatitude: event.addressLatitude,
      addressLongitude: event.addressLongitude,
      addressIsPrimary: event.addressIsPrimary,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.errMessage)),
      (registerResponse) => emit(RegisterSuccess(registerResponse)),
    );
  }
}