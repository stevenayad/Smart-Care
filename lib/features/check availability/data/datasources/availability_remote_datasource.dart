import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';

abstract class AvailabilityRemoteDataSource {
  Future<List<InventoryModel>> getAvailability(String productId);
}
