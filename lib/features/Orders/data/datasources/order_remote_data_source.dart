import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> getOrderById(String id);

  Future<OrderModel> getOrderDetails(String id);

  Future<List<OrderModel>> getOrdersByCustomer();

  Future<List<OrderModel>> getOrdersByCustomerAndStatus(String clientId, int status);

  
}
