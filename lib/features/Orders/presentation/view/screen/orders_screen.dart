import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_status_filter.dart';
import '../../bloc/orders_bloc.dart';
import '../../bloc/orders_state.dart';
import '../../bloc/orders_event.dart';
import '../widget/loading_widget.dart';
import '../widget/order_list_card.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = CacheHelper.getUserId().toString().trim();
    _fetchOrders();
  }

  void _fetchOrders() {
    context.read<OrdersBloc>().add(FetchOrdersByCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          OrderStatusFilter(
            clientId: userId,
            ordersBloc: context.read<OrdersBloc>(),
          ),
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
                          if (order.id == null || order.id!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid order ID!'),
                              ),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderDetailsScreen(
                                orderId: order.id!,
                                ordersBloc: context.read<OrdersBloc>(),
                              ),
                            ),
                          ).then((_) {
                            _fetchOrders();
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
    );
  }
}
