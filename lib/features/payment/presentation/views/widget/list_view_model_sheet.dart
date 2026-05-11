import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/payment/data/Model/payment_method.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/payment_item.dart';

class ListViewModelSheet extends StatelessWidget {
  const ListViewModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentCubit>();

    final selectedIndex = cubit.selectedIndex;

    final List<PaymentMethod> methods = [
      PaymentMethod(
        name: "Pay with Card",
        subtitle: "Visa / MasterCard",
        image: 'https://cdn-icons-png.flaticon.com/512/6963/6963703.png',
      ),

      PaymentMethod(
        name: "Cash",
        subtitle: "Pay when you receive",
        image: 'https://cdn-icons-png.flaticon.com/512/3523/3523887.png',
      ),
    ];

    if (cubit.state is PaymentLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: methods.length,

        itemBuilder: (context, index) {
          return PaymentItem(
            method: methods[index].copyWith(isSelected: selectedIndex == index),

            onTap: () {
              context.read<PaymentCubit>().selectPaymentMethod(index);
            },
          );
        },
      ),
    );
  }
}
