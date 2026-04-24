import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/Orders/data/repositories/order_repository_impl.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_bloc.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_event.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_state.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/loading_widget.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_list_card.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_status_filter.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiConsumer = DioConsumer(dio);
    final repository = OrderRepositoryImpl(apiConsumer: apiConsumer);
    return BlocProvider(
      create:(context) => OrdersBloc(repository: repository)..add(FetchOrdersByCustomer()) ,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppThemes.customAppBar(
          title: 'My orders',
          showBackButton: true,
        ),
        body: Column(
          children: [
            const OrderStatusFilter(), 
            Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const LoadingWidget();
                  } else if (state is OrdersError) {
                    return Center(child: Text(state.message));
                  } else if (state is OrdersListLoaded) {
                    final orders = state.orders;
      
                    if (orders.isEmpty) {
                      return const Center(child: Text('No orders found.'));
                    }
      
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
      
                        return OrderListCard(
                          order: order,
                          onTap: () {
                            if (order.id.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid order ID!'),
                                ),
                              );
                              return;
                            }
                            
                            final ordersBloc = context.read<OrdersBloc>();
                            ordersBloc.add(FetchOrderDetails(order.id));
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: ordersBloc,
                                  child: const OrderDetailsScreen(),
                                ),
                              ),
                            ).then((_) {
                              ordersBloc.add(RestoreOrdersList());
                            });
                          },
                        );
                      },
                    );
                  }
      
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}