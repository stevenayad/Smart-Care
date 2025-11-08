import 'package:dartz/dartz.dart';
import 'package:smartcare/core/faluire.dart';
import 'package:smartcare/features/stores/domain/entities/store_entity.dart';
import 'package:smartcare/features/stores/domain/repositories/store_repository.dart';
import 'package:smartcare/features/stores/data/data_sources/store_remote_data_source.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource remoteDataSource;

  StoreRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<StoreEntity>>> getStores() async {
    try {
      final storeModel = await remoteDataSource.fetchStores();
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
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
}
