import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/features/Orders/data/models/order_model.dart';
import 'order_remote_data_source.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiConsumer apiConsumer;

  OrderRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<OrderModel> getOrderById(String id) async {
    final response = await apiConsumer.get('/api/orders/$id', null);
    final data = response['data'] as Map<String, dynamic>;
    return OrderModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<OrderModel> getOrderDetails(String id) async {
    final response = await apiConsumer.get('/api/orders/details/$id', null);
    final data = response['data'] as Map<String, dynamic>;
    return OrderModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<List<OrderModel>> getOrdersByCustomer() async {
    final response = await apiConsumer.get('/api/me/orders',null);
    final list = response['data'] as List<dynamic>;
    return list.map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<List<OrderModel>> getOrdersByCustomerAndStatus(String clientId, int status) async {
    final response = await apiConsumer.get('/api/orders/by-customer-and-status', {'clientId': clientId, 'status': status});
    final list = response['data'] as List<dynamic>;
    return list.map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

}
