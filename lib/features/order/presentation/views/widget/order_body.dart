import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_summary_section.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo.dart';
import 'package:smartcare/features/payment/presentation/cubits/cubit/signalr_cubit.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/model_sheet_payment.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key, required this.orderid});
  final String orderid;

  @override
  Widget build(BuildContext context) {
    final signalRService = AppSignalRService(CacheHelper.getAccessToken()!);

    return SingleChildScrollView(
      child: Column(
        children: [
          const OrderSummarySection(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EvalutedButton(
              text: 'Processing Payment',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => PaymentCubit(
                          PaymentRepo(apiConsumer: DioConsumer(Dio())),
                        ),
                      ),
                      BlocProvider(
                        create: (_) => OrderCubit(
                          Orderrepo(apiConsumer: DioConsumer(Dio())),
                        ),
                      ),
                      BlocProvider(
                        create: (_) =>
                            PaymentSignalRCubit(signalRService: signalRService),
                      ),
                    ],
                    child: PaymentBottomSheet(orderid: orderid),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
