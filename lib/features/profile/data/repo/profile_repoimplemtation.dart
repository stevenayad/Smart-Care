import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/profile/data/Model/input_model/edit_profile_request.dart';
import 'package:smartcare/features/profile/data/Model/profile_model/profile_model.dart';

class ProfileRepoimplemtation {
  final DioConsumer api;

  ProfileRepoimplemtation({required this.api});

  Future<Either<Failure, ProfileModel>> getProfileData() async {
    final response = await api.get(
      'Users/clients/06aed2c2-af5c-40af-bb9d-7bd366f48043',
      null,
    );

    return response.fold((failure) => Left(failure), (data) {
      final profile = ProfileModel.fromMap(data);
      return Right(profile);
    });
  }

  Future<Either<Failure, ProfileModel>> Editprofile(
    EditProfileRequest editprofile,
  ) async {
    try {
      final response = await api.put(
        'Users/clients/update-profile',
        editprofile.toJson(),
      );

      final profile = ProfileModel.fromMap(response);
      return Right(profile);
    } on DioError catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }
}
