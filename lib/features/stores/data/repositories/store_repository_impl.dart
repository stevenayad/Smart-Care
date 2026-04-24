import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/stores/data/models/store_model.dart';
import 'package:smartcare/features/stores/data/repositories/store_repository.dart';
import 'package:smartcare/core/api/api_consumer.dart';
class StoreRepositoryImpl implements StoreRepository {
  final ApiConsumer apiConsumer;

  StoreRepositoryImpl(this.apiConsumer);

  @override
  Future<Either<Failure, List<storeData>>> getStores() async {
    try {
      final response = await apiConsumer.get('/api/Stores', null);

      final model = StoreModel.fromJson(response);

      return Right(model.data ?? []);
    } on DioException catch (dioError) {
      return Left(servivefailure.fromDioError(dioError));
    } catch (e) {
      return Left(servivefailure("Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, storeData>> getNearestStore({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await apiConsumer.get(
        '/api/stores/nearest',
        {
          'Latitude': latitude,
          'Longitude': longitude,
        },
      );

      final model = StoreModel.fromJson(response);

      if (model.data == null || model.data!.isEmpty) {
        return Left(servivefailure("No nearest store found"));
      }

      return Right(model.data!.first);
    } catch (e) {
      return Left(servivefailure("Unexpected error: ${e.toString()}"));
    }
  }
}