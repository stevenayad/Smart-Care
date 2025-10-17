import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/profile/data/Model/profile_model/profile_model.dart';

class ProfileRepoimplemtation {
  final DioConsumer api;

  ProfileRepoimplemtation({required this.api});

  Future<Either<Failure, ProfileModel>> getProfileData() async {
    final response = await api.get(
      'Users/clients/7af42dd9-9898-413f-ac49-8daa514eff17',
      null,
    );

    return response.fold((failure) => Left(failure), (data) {
      final profile = ProfileModel.fromMap(data);
      return Right(profile);
    });
  }
}
