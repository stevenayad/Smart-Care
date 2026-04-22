
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/model_sheet_payment.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({required this.orderId});
  final String orderId;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        builder: (_) => BlocProvider.value(
          value: context.read<PaymentCubit>(),
          child: PaymentBottomSheet(orderid: widget.orderId)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}