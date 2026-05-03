import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';

class DeliveryStrategy implements OrderStrategy {
  final String? addressId;

  DeliveryStrategy(this.addressId);

  @override
  bool validate(BuildContext context) {
    if (addressId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an address!")),
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
    return cubit.createDeliveryOrder(cartId: cartId, addressId: addressId!);
  }


}