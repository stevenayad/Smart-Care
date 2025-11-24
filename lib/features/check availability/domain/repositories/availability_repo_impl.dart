import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/check%20availability/data/datasources/availability_remote_datasource.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';
import 'package:smartcare/features/check%20availability/domain/repositories/availability_repo.dart';

class AvailabilityRepoImpl implements AvailabilityRepo {
  AvailabilityRemoteDataSource remote;
  AvailabilityRepoImpl({required this.remote});
  @override
  Future<Either<Failure, List<InventoryModel>>> checkAvailability(
    String productId,
  ) async {
    try {
      final result = await remote.getAvailability(productId);
      return Right(result);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
}
