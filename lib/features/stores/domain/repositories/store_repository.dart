import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<StoreEntity>>> getStores();
  Future<Either<Failure, StoreEntity>> getNearestStore({
    required double latitude,
    required double longitude,
  });
}
