import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import '../../bloc/orders_bloc.dart';
import '../../bloc/orders_event.dart';
import '../../bloc/orders_state.dart';
import '../widget/loading_widget.dart';
import '../widget/order_item_widget.dart';
import '../widget/order_header_widget.dart';
import '../widget/order_address_widget.dart';
import '../widget/order_total_widget.dart';
import '../widget/out_of_stock_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final OrdersBloc ordersBloc;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.ordersBloc,
  });

  @override
  Widget build(BuildContext context) {
    // Use BlocProvider.value to reuse existing bloc
    return BlocProvider.value(
      value: ordersBloc..add(FetchOrderDetails(orderId)),
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          title: const Text("Order Details"),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const LoadingWidget();
            } else if (state is OrdersError) {
              return Center(child: Text(state.message));
            } else if (state is OrderLoaded) {
              final order = state.order;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header (ID, Status, Date)
                    OrderHeaderWidget(order: order),
                    const SizedBox(height: 16),

                    // 2. Shipping Address
                    if (order.address != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          "Delivery Address",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      OrderAddressWidget(order: order),
                      const SizedBox(height: 20),
                    ],
                    if (order.store != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          "Store Details",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.mediumGrey.withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name: ${order.store!.name}"),
                            Text("Address: ${order.store!.address}"),
                            Text("Phone: ${order.store!.phone}"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // 3. Out of Stock Items
                    if (order.outOfStocks != null &&
                        order.outOfStocks!.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          "Out of Stock Items",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      ...order.outOfStocks!
                          .map((oos) => OutOfStockWidget(oos: oos))
                          .toList(),
                      const SizedBox(height: 20),
                    ],

                    // 4. Order Items List
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 8),
                      child: Text(
                        "Items",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.mediumGrey.withOpacity(0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: order.orderItems?.length ?? 0,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: OrderItemWidget(
                              item: order.orderItems![index],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 5. Total Price
                    OrderTotalWidget(order: order),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
