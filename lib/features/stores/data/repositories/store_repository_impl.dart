import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/stores/data/models/store_model.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';
import 'package:smartcare/features/stores/domain/repositories/store_repository.dart';
import 'package:smartcare/core/api/api_consumer.dart';

class StoreRepositoryImpl implements StoreRepository {
  final ApiConsumer apiConsumer;

  StoreRepositoryImpl(this.apiConsumer);

  @override
  Future<Either<Failure, List<StoreEntity>>> getStores() async {
    try {
      final response = await apiConsumer.get('/api/Stores', null);

      final storeModel = StoreModel.fromJson(response);

      final List<StoreEntity> stores = storeModel.data!.map((data) {
        return StoreEntity(
          id: data.id!,
          name: data.name!,
          address: data.address!,
          latitude: data.latitude!,
          longitude: data.longitude!,
          phone: data.phone!,
        );
      }).toList();

      return Right(stores);
    } on DioException catch (dioError) {
      return Left(servivefailure.fromDioError(dioError));
    } catch (e) {
      return Left(servivefailure("Unexpected error occurred: ${e.toString()}"));
    }
  }
}
