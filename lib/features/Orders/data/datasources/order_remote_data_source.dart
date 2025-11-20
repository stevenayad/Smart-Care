import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  /// GET /api/orders/{id}
  Future<OrderModel> getOrderById(String id);

  /// GET /api/orders/details/{id}
  Future<OrderModel> getOrderDetails(String id);

  /// GET /api/orders/by-customer?clientId=...
  Future<List<OrderModel>> getOrdersByCustomer();

  /// GET /api/orders/by-customer-and-status?clientId=...&status=...
  Future<List<OrderModel>> getOrdersByCustomerAndStatus(String clientId, int status);

  /// POST /api/orders/create-online-order  (body: {cartId, deliveryAddressId})
  Future<OrderModel> createOnlineOrder({required String cartId, required String deliveryAddressId});

  /// POST /api/orders/create-pickup-order (body: {cartId, storeId})
  Future<OrderModel> createPickupOrder({required String cartId, required String storeId});
}
