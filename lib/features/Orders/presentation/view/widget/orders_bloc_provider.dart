import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/Orders/domain/repositories/order_repository_impl.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_bloc.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_event.dart';
import 'package:smartcare/features/Orders/presentation/view/screen/orders_screen.dart';

BlocProvider<OrdersBloc> buildOrdersBlocScreen() {
  final dio = Dio();
  final apiConsumer = DioConsumer(dio);
  final repository = OrderRepositoryImpl(apiConsumer: apiConsumer);



  return BlocProvider(
    create: (_) => OrdersBloc(
      repository: repository
    )..add(FetchOrdersByCustomer()),
    child: const OrdersScreen(),
  );
}
