import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/delivery_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';

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
            final hasOrder = orderState is OrderHasActive;
            print('orderID----${orderCubit.orderid}');
            print('CartID----${cartId}');
            print('has order ${hasOrder} ');

            if (cartId == null || cartState is CartInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            return EvalutedButton(
              text: hasOrder ? 'Update Order' : 'Confirm Order',
              onTap: () =>
                  _onTap(context: context, cartId: cartId, hasOrder: hasOrder),
            );
          },
        );
      },
    );
  }

  void _onTap({
    required BuildContext context,
    required String cartId,
    required bool hasOrder,
  }) {
    final deliveryState = context.read<DeliveryCubit>().state;
    final selectedTab = deliveryState.selectedTab;
    final selectedStoreId = deliveryState.selectedStoreId;
    final selectedAddressId = deliveryState.selectedAddressId;

    if (!hasOrder) {
      if (!_validateSelection(
        context: context,
        selectedTab: selectedTab,
        selectedStoreId: selectedStoreId,
        selectedAddressId: selectedAddressId,
      )) {
        return;
      }

      final orderCubit = context.read<OrderCubit>();
      if (selectedTab == 0) {
        orderCubit.createDeliveryOrder(
          cartId: cartId,
          addressId: selectedAddressId!,
        );

        return;
      }

      if (selectedTab == 1) {
        orderCubit.createPickupOrder(cartId: cartId, storeId: selectedStoreId!);

        return;
      }

      return;
    }

    context.read<OrderCubit>().updateOrderFromSelection(
      cartId: cartId,
      updatedOrderType: selectedTab,
      storeId: selectedTab == 1 ? selectedStoreId : null,
      shippingAddressId: selectedTab == 0 ? selectedAddressId : null,
    );
  }

  bool _validateSelection({
    required BuildContext context,
    required int selectedTab,
    required String? selectedStoreId,
    required String? selectedAddressId,
  }) {
    if (selectedTab == 0 && selectedAddressId == null) {
      _showSnackBar(context, "Please select an address!");
      return false;
    }

    if (selectedTab == 1 && selectedStoreId == null) {
      _showSnackBar(context, "Please select a store!");
      return false;
    }

    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
