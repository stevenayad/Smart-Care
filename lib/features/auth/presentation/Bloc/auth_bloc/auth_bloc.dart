// file: features/auth/presentation/bloc/auth_bloc.dart

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
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

    final Either<Failure, LoginResponseModel> result = await _authRepository
        .login(event.email, event.password);

    if (result.isRight()) {
      final loginResponse =
          (result as Right<Failure, LoginResponseModel>).value;

      final String? accessToken = loginResponse.data?.accessToken;
      if (accessToken != null) {
        await CacheHelper.saveAccessToken(accessToken);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        final String userId =
            decodedToken['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
        await CacheHelper.saveUserId(userId);
        emit(LoginSuccess(loginResponse));
      } else {
        emit(AuthFailure('Login failed: Token was not provided.'));
      }
    } else {
      final failure = (result as Left<Failure, LoginResponseModel>).value;
      emit(AuthFailure(failure.errMessage));
    }
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
