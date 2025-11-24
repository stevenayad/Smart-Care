import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/features/check%20availability/data/datasources/availability_remote_datasource.dart';
import 'package:smartcare/features/check%20availability/data/model/inventory_model.dart';

class AvailabilityRemoteDataSourceImpl implements AvailabilityRemoteDataSource {
  final ApiConsumer api;
  AvailabilityRemoteDataSourceImpl({required this.api});
  @override
  Future<List<InventoryModel>> getAvailability(String productId) async {
    final response = await api.get("/api/Inventories/GetAvailableInventory", {
      "productId": productId,
    });
    final List list = response["data"] ?? [];
    return list.map((e) => InventoryModel.fromJson(e)).toList();
  }
}
