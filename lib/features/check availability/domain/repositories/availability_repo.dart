import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';

abstract class AvailabilityRepo {
  Future<Either<Failure, List<InventoryModel>>> checkAvailability(
    String productId,
  );
}
