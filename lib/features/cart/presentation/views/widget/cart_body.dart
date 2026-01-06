import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/cart/presentation/views/widget/cart_listview_with_summary.dart';
import 'package:smartcare/features/cart/presentation/views/widget/order_info_section.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          return Center(child: const Text('NO Item Yet'));
        }

        if (state is CartFailure) {
          return Center(child: Text(state.errmessage));
        }

        if (state is GetItemSucces) {
          final items = state.itemsCart.data ?? [];
          return CartListWithSummary(items: items);
        }

        return const SizedBox();
      },
    );
  }
}
