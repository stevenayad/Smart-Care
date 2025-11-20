import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/Orders/data/datasources/order_remote_data_source_impl.dart';
import 'package:smartcare/features/Orders/domain/repositories/order_repository_impl.dart';
import 'package:smartcare/features/Orders/domain/usecases/get_order_by_id.dart';
import 'package:smartcare/features/Orders/domain/usecases/get_order_details.dart';
import 'package:smartcare/features/Orders/domain/usecases/get_orders_by_customer.dart';
import 'package:smartcare/features/Orders/domain/usecases/get_orders_by_customer_and_status.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_bloc.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_event.dart';
import 'package:smartcare/features/Orders/presentation/view/screen/orders_screen.dart';


/// Returns a BlocProvider wrapping OrdersScreen
BlocProvider<OrdersBloc> buildOrdersBlocScreen() {
  final dio = Dio();
  final apiConsumer = DioConsumer(dio);
  final remoteDataSource = OrderRemoteDataSourceImpl(apiConsumer: apiConsumer);
  final repository = OrderRepositoryImpl(remoteDataSource: remoteDataSource);

  // Usecases
  final getOrderById = GetOrderById(repository);
  final getOrderDetails = GetOrderDetails(repository);
  final getOrdersByCustomer = GetOrdersByCustomer(repository);
  final getOrdersByCustomerAndStatus = GetOrdersByCustomerAndStatus(repository);

  return BlocProvider(
    create: (_) => OrdersBloc(
      getOrderById: getOrderById,
      getOrderDetails: getOrderDetails,
      getOrdersByCustomer: getOrdersByCustomer,
      getOrdersByCustomerAndStatus: getOrdersByCustomerAndStatus,
    )..add(FetchOrdersByCustomer()),
    child: const OrdersScreen(),
  );
}
