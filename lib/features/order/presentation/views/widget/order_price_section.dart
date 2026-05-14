import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/price_row_item.dart';

class OrderPriceSection extends StatelessWidget {
  const OrderPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final details = state.orderDetails?.data;

        final totalPrice = details?.totalPrice ?? 0;

        final deliveryFees = details?.deliveryFees ?? 0;

        final medicinePrice = totalPrice - deliveryFees;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              PriceRowItem(
                title: 'Medicine Price',
                value: medicinePrice,
              ),
              const SizedBox(height: 12),
              PriceRowItem(
                title: 'Delivery Fees',
                value: deliveryFees,
              ),
              const Divider(height: 30),
              PriceRowItem(
                title: 'Total',
                value: totalPrice,
                isBold: true,
              ),
            ],
          ),
        );
      },
    );
  }

 
}