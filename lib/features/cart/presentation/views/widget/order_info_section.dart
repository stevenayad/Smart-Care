import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/order/presentation/views/delviery_screen.dart';
import 'package:smartcare/features/order/presentation/views/orderscreen.dart';
import 'package:smartcare/features/order/presentation/views/widget/delivery_selection.dart';
import 'orderinforow.dart';

class OrderInfoSection extends StatelessWidget {
  const OrderInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = BlocProvider.of<CartCubit>(context);
        final items = cartCubit.cartItems;

        double subtotal = 0;
        for (var item in items) {
          subtotal += (item.totalPrice ?? 0);
        }

        double total = subtotal;

        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Cart Summary",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Orderinforow(
                text: 'Subtotal',
                value: '${subtotal.toStringAsFixed(2)} EGP',
              ),

              const Divider(thickness: 1.5),

              Orderinforow(
                text: 'Total',
                value: '${total.toStringAsFixed(2)} EGP',
                bold: true,
              ),

              const SizedBox(height: 10),
              EvalutedButton(
                text: 'CHECKOUT',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DelvieryScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
