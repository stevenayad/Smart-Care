import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy_factory.dart';

import 'package:smartcare/features/order/presentation/cubits/delivery/checkout_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';

class OrderActionButton extends StatelessWidget {
  const OrderActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, orderState) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            final cartCubit = context.read<CartCubit>();
            final cartId = cartCubit.cartId;

            final orderCubit = context.read<OrderCubit>();
            final orderId = orderCubit.orderid;

            final hasOrder = orderState is OrderHasActive;

            if (cartId == null || cartState is CartInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            final isDisabled = hasOrder && orderId == null;

            return EvalutedButton(
              text: hasOrder ? 'Update Order' : 'Confirm Order',
              onTap: isDisabled
                  ? null
                  : () => _onTap(
                      context: context,
                      cartId: cartId,
                      orderId: orderId,
                      hasOrder: hasOrder,
                    ),
            );
          },
        );
      },
    );
  }

  Future<void> _onTap({
    required BuildContext context,
    required String cartId,
    String? orderId,
    required bool hasOrder,
  }) async {
    final deliveryState = context.read<CheckoutCubit>().state;
    final selectedTab = deliveryState.selectedTab;
    final selectedStoreId = deliveryState.selectedStoreId;
    final selectedAddressId = deliveryState.selectedAddressId;

    if (!hasOrder) {
      await context.read<OrderCubit>().createOrderFromSelection(
        context: context,
        tab: selectedTab,
        cartId: cartId,
        addressId: selectedAddressId,
        storeId: selectedStoreId,
      );
      return;
    }

    if (orderId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Order id is null')));
      return;
    }

    await context.read<OrderCubit>().updateOrderFromSelection(
      orderId: orderId,
      cartId: cartId,
      updatedOrderType: selectedTab,
      shippingAddressId: selectedAddressId,
      storeId: selectedStoreId,
    );
  }
}
