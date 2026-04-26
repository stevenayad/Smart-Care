import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
import 'package:smartcare/features/payment/presentation/cubits/cubit/signalr_cubit.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/paymet_view.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final signalRService = AppSignalRService(CacheHelper.getAccessToken()!);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PaymentCubit(PaymentRepo(apiConsumer: DioConsumer(Dio()))),
        ),
        BlocProvider(
          create: (_) => OrderCubit(Orderrepo(apiConsumer: DioConsumer(Dio()))),
        ),
        BlocProvider(
          create: (_) => PaymentSignalRCubit(signalRService: signalRService),
        ),
      ],
      child: PaymentView(orderId: orderId),
    );
  }
}
