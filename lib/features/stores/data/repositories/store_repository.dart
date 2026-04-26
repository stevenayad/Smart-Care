import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/Orders/data/models/store_model.dart';

import 'package:smartcare/features/stores/data/models/store_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<storeData>>> getStores();
  Future<Either<Failure, storeData>> getNearestStore({
    required double latitude,
    required double longitude,
  });
}
