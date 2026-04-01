import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/delivery/delivery_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_ui_handler.dart';
import 'package:smartcare/features/order/presentation/views/widget/order_action_button.dart';
import 'package:smartcare/features/order/presentation/views/widget/delivery_selection.dart';

class DelvieryScreen extends StatelessWidget {
  const DelvieryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final signalRService = AppSignalRService(CacheHelper.getAccessToken()!);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AddressStoreCubit(Orderrepo(apiConsumer: DioConsumer(Dio())))
                ..getaddress()
                ..getstore(),
        ),
        BlocProvider(create: (_) => DeliveryCubit()),
        BlocProvider.value(value: context.read<OrderCubit>()),
        BlocProvider.value(value: context.read<CartCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppThemes.customAppBar(
              title: 'Pickup or Delivery',
              showBackButton: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const DeliverySelection(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocListener<OrderCubit, OrderState>(
                      listener: OrderUiHandler.handleOrderState,
                      child: const OrderActionButton(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
