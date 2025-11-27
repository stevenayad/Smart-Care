import '../../data/models/store_model.dart'; // <-- Order's store model

import '../../data/models/address_model.dart';
import '../../data/models/order_item_model.dart';
import '../../data/models/out_of_stock_model.dart';

class Orderr {
  final String id;
  final String? clientId;
  final int? paymentId;
  final AddressModel? address;
  final StoreModel? store; // unified
  final double? totalPrice;
  final int? status;
  final DateTime? createdAt;
  final List<OrderItemModel>? orderItems;
  final List<OutOfStockModel>? outOfStocks;

  Orderr({
    required this.id,
    this.clientId,
    this.paymentId,
    this.address,
    this.store,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.orderItems,
    this.outOfStocks,
  });
}
