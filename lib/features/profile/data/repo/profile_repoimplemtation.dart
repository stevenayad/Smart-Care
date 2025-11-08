import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/profile/data/Model/input_model/edit_profile_request.dart';
import 'package:smartcare/features/profile/data/Model/profiledata/profiledata.dart';

class ProfileRepoimplemtation {
  final DioConsumer api;

  ProfileRepoimplemtation({required this.api});

  Future<Either<Failure, Profiledata>> getProfileData() async {
    try {
      final rawId = CacheHelper.getUserId();
      print("🧩 Raw ID: '$rawId' (${rawId?.length})");
      final userId = rawId?.trim();
      print("✨ Trimmed ID: '$userId' (${userId?.length})");

      final response = await api.get("api/Users/clients/$userId",null);

      print('Response Type: ${response.runtimeType}');
      print('Response Data: ${response}');

      if (response is Map<String, dynamic>) {
        final profile = Profiledata.fromJson(response);
        print("✅ Parsed successfully: ${profile.data?.firstName}");
        return Right(profile);
      } else {
        return Left(servivefailure("Unexpected response format"));
      }
    } on DioException catch (e) {
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, Profiledata>> Editprofile(
    EditProfileRequest editprofile,
  ) async {
    try {
      final response = await api.put(
        'Users/clients/update-profile',
        editprofile.toJson(),
      );

      final profile = Profiledata.fromJson(response);
      return Right(profile);
    } on DioError catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }
}
