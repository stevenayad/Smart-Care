import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/payment/data/Model/payment_method.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/payment_item.dart';

class ListViewModelSheet extends StatefulWidget {
  const ListViewModelSheet({super.key});

  @override
  State<ListViewModelSheet> createState() => _ListViewModelSheetState();
}

class _ListViewModelSheetState extends State<ListViewModelSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentCubit>().loadPaymentProvider();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          final cubit = context.watch<PaymentCubit>();
          final provider = cubit.paymentProvider;
          final selectedIndex = cubit.selectedIndex;

          /// ⏳ لو لسه بيحمل
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<PaymentMethod> methods = [
            provider == 0
                ? PaymentMethod(
                    name: "Pay with Card (Stripe)",
                    subtitle: "Visa / MasterCard",
                    image:
                        'https://cdn-icons-png.flaticon.com/512/6963/6963703.png',
                  )
                : PaymentMethod(
                    name: "Pay with Paymob",
                    subtitle: "All payment methods",
                    icon: Icons.credit_card,
                  ),
            PaymentMethod(
              name: "Cash on Delivery",
              subtitle: "Pay when you receive",
              image: 'https://cdn-icons-png.flaticon.com/512/3523/3523887.png',
            ),
          ];

          return ListView.builder(
            itemCount: methods.length,
            itemBuilder: (context, index) {
              return PaymentItem(
                method: methods[index].copyWith(
                  isSelected: selectedIndex == index,
                ),
                onTap: () {
                  context.read<PaymentCubit>().selectPaymentMethod(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
