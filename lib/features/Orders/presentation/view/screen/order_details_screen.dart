import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/Orders/data/repositories/order_repository_impl.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_item_list.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/section_title.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/store_details.dart';
import '../../bloc/orders_bloc.dart';
import '../../bloc/orders_state.dart';
import '../widget/loading_widget.dart';
import '../widget/order_item_widget.dart';
import '../widget/order_header_widget.dart';
import '../widget/order_address_widget.dart';
import '../widget/order_total_widget.dart';
import '../widget/out_of_stock_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppThemes.customAppBar(
        title: 'Order Details',
        showBackButton: true,
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
                  OrderHeaderWidget(order: order),
                  const SizedBox(height: 16),

                  /// Address
                  if (order.address != null) ...[
                    const SectionTitle(title: "Delivery Address"),
                    OrderAddressWidget(order: order),
                    const SizedBox(height: 20),
                  ],

                  /// Store
                  if (order.store != null) ...[
                    const SectionTitle(title: "Store Details"),
                    StoreDetailsWidget(store: order.store!),
                    const SizedBox(height: 20),
                  ],

                  /// Out of stock
                  if (order.outOfStocks != null &&
                      order.outOfStocks!.isNotEmpty) ...[
                    const SectionTitle(
                      title: "Out of Stock Items",
                      isError: true,
                    ),
                    ...order.outOfStocks!
                        .map((oos) => OutOfStockWidget(oos: oos))
                        .toList(),
                    const SizedBox(height: 20),
                  ],

                  /// Items
                  const SectionTitle(title: "Items"),
                  OrderItemsList(order: order),
                  const SizedBox(height: 20),

                  /// Total
                  OrderTotalWidget(order: order),
                  const SizedBox(height: 30),
                ],
              ),
            );
          }

          // Fallback UI for any other state (like OrdersInitial or OrdersListLoaded)
          // which might happen if navigation is very fast or state hasn't changed yet
          return const Center(child: LoadingWidget());
        },
      ),
    );
  }
}
