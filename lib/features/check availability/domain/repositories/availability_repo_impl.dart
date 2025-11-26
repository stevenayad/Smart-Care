import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';
import 'package:smartcare/features/check%20availability/domain/repositories/availability_repo.dart';

class AvailabilityRepoImpl implements AvailabilityRepo {
  final ApiConsumer api;
  AvailabilityRepoImpl({required this.api});

  @override
  Future<Either<Failure, List<InventoryModel>>> checkAvailability(
      String productId) async {
    try {
      final response = await api.get("/api/Inventories/GetAvailableInventory", {
        "productId": productId,
      });

      final List list = response["data"] ?? [];
      final inventories = list.map((e) => InventoryModel.fromJson(e)).toList();
      return Right(inventories);
    } catch (e) {
      return Left(servivefailure(e.toString()));
    }
  }
}
