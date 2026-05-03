import 'package:flutter/material.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';

abstract class OrderStrategy {
  bool validate(BuildContext context);
  Future<void> execute({
    required OrderCubit cubit,
    required String cartId,
  });
}
