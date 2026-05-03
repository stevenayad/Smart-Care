import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';

class PickupStrategy implements OrderStrategy {
  final String? storeId;

  PickupStrategy(this.storeId);

  @override
  bool validate(BuildContext context) {
    if (storeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a store!")),
      );
      return false;
    }
    return true;
  }

  @override
  Future<void> execute({
    required OrderCubit cubit,
    required String cartId,
  }) {
    return cubit.createPickupOrder(cartId: cartId, storeId: storeId!);
  }


}