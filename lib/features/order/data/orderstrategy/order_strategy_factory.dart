import 'package:smartcare/features/order/data/orderstrategy/delivery_strategy.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy.dart';
import 'package:smartcare/features/order/data/orderstrategy/pickup_strategy.dart';

class OrderStrategyFactory {
  static OrderStrategy getStrategy({
    required int tab,
    String? addressId,
    String? storeId,
  }) {
    switch (tab) {
      case 0:
        return DeliveryStrategy(addressId);
      case 1:
        return PickupStrategy(storeId);
      default:
        throw Exception("Unknown strategy");
    }
  }
}