import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';

class OrderService {
  final Map<int, OrderStrategy Function({
    String? addressId,
    String? storeId,
  }) > strategies;

  OrderService({required this.strategies});

   Future<void> process({
    required BuildContext context,
    required int tab,
    required OrderCubit cubit,
    required String cartId,
    String? addressId,
    String? storeId,
  }) async {
    final builder = strategies[tab];

    if (builder == null) {
      throw Exception("Unknown strategy");
    }

    final strategy = builder(
      addressId: addressId,
      storeId: storeId,
    );


    if (!strategy.validate(context)) return;


    await strategy.execute(
      cubit: cubit,
      cartId: cartId,
    );
  }
}