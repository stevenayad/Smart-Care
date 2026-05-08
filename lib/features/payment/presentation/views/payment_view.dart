import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/order/data/orderstrategy/delivery_strategy.dart';
import 'package:smartcare/features/order/data/orderstrategy/order_strategy_factory.dart';
import 'package:smartcare/features/order/data/orderstrategy/pickup_strategy.dart';
import 'package:smartcare/features/order/data/repo/order_repo_implementation.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/payment/data/paymentmethod/payment_services.dart';
import 'package:smartcare/features/payment/data/paymentmethod/paymob_strategy.dart';
import 'package:smartcare/features/payment/data/paymentmethod/stripe_strategy.dart';
import 'package:smartcare/features/payment/data/repo/payment_repo_implementation.dart';
import 'package:smartcare/features/payment/presentation/cubits/signalr/signalr_cubit.dart';
import 'package:smartcare/features/payment/presentation/cubits/payment/payment_cubit.dart';
import 'package:smartcare/features/payment/presentation/views/widget/model_sheet_payment.dart';

void showPaymentSheet(BuildContext context, String orderId) {
  final token = CacheHelper.getAccessToken();

  if (token == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Token not found")));
    return;
  }

  final signalRService = AppSignalRService(token);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PaymentCubit(
              PaymentRepoImpl(apiConsumer: DioConsumer(Dio())),
              paymentService: PaymentService(
                strategies: {
                  0: StripePaymentStrategy(),
                  1: PaymobPaymentStrategy(),
                },
              ),
            ),
          ),
          BlocProvider(
            create: (_) => OrderCubit(
              OrderRepoImplementation(apiConsumer: DioConsumer(Dio())),
              orderService: OrderService(
                strategies: {
                  0: ({addressId, storeId}) => DeliveryStrategy(addressId),
                  1: ({addressId, storeId}) => PickupStrategy(storeId),
                },
              ),
            ),
          ),
          BlocProvider(
            create: (_) => PaymentSignalRCubit(signalRService: signalRService),
          ),
        ],
        child: PaymentBottomSheet(orderid: orderId),
      );
    },
  );
}
