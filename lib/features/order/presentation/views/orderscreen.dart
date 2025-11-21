import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/appbar.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_body.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/custom_appbar.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = OrderCubit(Orderrepo(apiConsumer: DioConsumer(Dio())));
        cubit.getorderdetails(orderId);

        return cubit;
      },
      child: Scaffold(
        appBar: buildGradientAppBar(
          'Order',
          onBack: () => Navigator.pop(context),
        ),
        body: OrderBody(),
      ),
    );
  }
}
