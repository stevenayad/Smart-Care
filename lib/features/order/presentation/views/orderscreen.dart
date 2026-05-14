import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_body.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key, required this.orderId});
  final String orderId;

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;

    final cubit = context.read<OrderCubit>();

    final currentOrderId =
        cubit.state.orderDetails?.data?.id;

    if (currentOrderId != widget.orderId) {
      cubit.getorderdetails(widget.orderId);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.customAppBar(title: 'Order', showBackButton: true),
      body: OrderBody(orderid: widget.orderId),
    );
  }
}
