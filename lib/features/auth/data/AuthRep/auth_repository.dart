import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/auth/data/Model/auth_model.dart';
import 'package:smartcare/features/auth/data/Model/base_bool_response.dart';

class AuthRepository {
  final ApiConsumer api;

  AuthRepository(this.api);

  Future<Either<Failure, LoginResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      final data = await api.post("/api/auth/login", {
        "email": email,
        "password": password,
      }, false);

      if (data is Failure) {
        return Left(data);
      }

      return Right(LoginResponseModel.fromJson(data));
    } on DioError catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

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
      print('📦 Sending form data:');
      for (var f in formData.fields) {
        print('${f.key}: ${f.value}');
      }
      final data = await api.post("/api/auth/sign-up", formData, true);

      // if (data is Failure) {
      //   return Left(data);
      // }

      return Right(RegisterResponseModel.fromJson(data));
    } on DioError catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        final data = e.response!.data;

        if (data["errorsBag"] != null && data["errorsBag"] is Map) {
          final bag = data["errorsBag"] as Map;
          final firstKey = bag.keys.first;
          final firstError = (bag[firstKey] as List).first;

          return Left(servivefailure(firstError));
        }
      }

      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
  // ===================== FORGOT PASSWORD =============================

  Future<Either<Failure, BaseBoolResponse>> sendResetCode(String email) async {
    try {
      final data = await api.post("/api/auth/send-reset-code", {
        "email": email,
      }, false);

      return Right(BaseBoolResponse.fromJson(data));
    } on DioError catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        final data = e.response!.data;

        if (data["errorsBag"] != null && data["errorsBag"] is Map) {
          final bag = data["errorsBag"] as Map;
          final firstKey = bag.keys.first;
          final firstError = (bag[firstKey] as List).first;

          return Left(servivefailure(firstError));
        }
      }

      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, BaseBoolResponse>> confirmResetPasswordCode(
    String email,
    String code,
  ) async {
    try {
      final data = await api.post("/api/auth/confirm-reset-password-code", {
        "email": email,
        "code": code,
      }, false);

      return Right(BaseBoolResponse.fromJson(data));
    } on DioError catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        final data = e.response!.data;

        if (data["errorsBag"] != null && data["errorsBag"] is Map) {
          final bag = data["errorsBag"] as Map;
          final firstKey = bag.keys.first;
          final firstError = (bag[firstKey] as List).first;

          return Left(servivefailure(firstError));
        }
      }

      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }

  Future<Either<Failure, BaseBoolResponse>> resetPassword(
    String email,
    String newPassword,
  ) async {
    try {
      final data = await api.post("/api/auth/reset-password", {
        "email": email,
        "newPassword": newPassword,
      }, false);

      return Right(BaseBoolResponse.fromJson(data));
    } on DioError catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        final data = e.response!.data;

        if (data["errorsBag"] != null && data["errorsBag"] is Map) {
          final bag = data["errorsBag"] as Map;
          final firstKey = bag.keys.first;
          final firstError = (bag[firstKey] as List).first;

          return Left(servivefailure(firstError));
        }
      }

      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
}
