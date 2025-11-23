import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_summary_header.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_summary_listview.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrderFailure) {
          return Center(
            child: Text(
              state.errmessage,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        if (state is orderdetailssuccess) {
          final details = state.orderDetails;
          final orderItems = details.data?.orderItems ?? [];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                OrderSummaryHeader(
                  totalItems: orderItems.length,
                  totalPrice: orderItems.fold<double>(
                    0,
                    (sum, item) => sum + (item.subTotal ?? 0),
                  ),
                ),
                const SizedBox(height: 16),
                OrderSummaryList(orderItems: orderItems),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
