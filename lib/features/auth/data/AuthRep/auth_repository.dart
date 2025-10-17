// file: features/auth/data/repository/auth_repository.dart

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/auth/data/Model/auth_model.dart';

class AuthRepository {
  final ApiConsumer api;

  AuthRepository(this.api);

  // MODIFIED: Return type changed to Either<Failure, LoginResponseModel> for robust error handling.
  Future<Either<Failure, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final data = await api.post("/api/auth/login", {
        "email": email,
        "password": password,
      }, false);

      // Check if the API consumer returned a failure object
      if (data is Failure) {
        return Left(data);
      }
      // final loginModel = LoginData.fromJson(data);
      // final tokendecode = JwtDecoder.decode(loginModel.accessToken!);
      // final id =
      //     tokendecode['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
      // print("-----------------------------------------$id");
      return Right(LoginResponseModel.fromJson(data));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  // MODIFIED: Return type changed to Either<Failure, RegisterResponseModel>
  Future<Either<Failure, RegisterResponseModel>> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
    required String email,
    required String password,
    required String birthDate,
    required int gender,
    required XFile profileImage,
    required int accountType,
    required String address,
    required String addressLabel,
    String? addressAdditionalInfo,
    required double addressLatitude,
    required double addressLongitude,
    required bool addressIsPrimary,
  }) async {
    final MultipartFile imageFile;
    if (kIsWeb) {
      // On web, we read the bytes and create a MultipartFile from the stream.
      var bytes = await profileImage.readAsBytes();
      imageFile = MultipartFile.fromBytes(bytes, filename: profileImage.name);
    } else {
      // On mobile, the original fromFile method works perfectly.
      imageFile = await MultipartFile.fromFile(
        profileImage.path,
        filename: profileImage.name,
      );
    }
    try {
      final formData = FormData.fromMap({
        "FirstName": firstName,
        "LastName": lastName,
        "UserName": userName,
        "PhoneNumber": phoneNumber,
        "Email": email,
        "Password": password,
        "BirthDate": birthDate,
        "Gender": gender,
        "ProfileImage": imageFile,
        "AccountType": accountType,
        "Address.address": address,
        "Address.Label": addressLabel,
        if (addressAdditionalInfo != null)
          "Address.AdditionalInfo": addressAdditionalInfo,
        "Address.Latitude": addressLatitude,
        "Address.Longitude": addressLongitude,
        "Address.IsPrimary": addressIsPrimary,
      });

      final data = await api.post("/api/auth/sign-up", formData, true);

      if (data is Failure) {
        return Left(data);
      }

      return Right(RegisterResponseModel.fromJson(data));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
}
