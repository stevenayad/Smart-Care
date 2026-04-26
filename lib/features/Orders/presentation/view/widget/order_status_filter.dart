import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_bloc.dart';
import 'package:smartcare/features/Orders/presentation/bloc/orders_event.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/order_status_helper.dart';

class OrderStatusFilter extends StatelessWidget {
  const OrderStatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersBloc = context.read<OrdersBloc>();
    final clientId = CacheHelper.getUserId().toString().trim();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownButtonFormField<int?>(
        decoration: InputDecoration(
          labelText: 'Filter by Status',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        value: null,
        items: [
          const DropdownMenuItem<int?>(value: null, child: Text('All')),
          ...List.generate(10, (index) {
            return DropdownMenuItem<int?>(
              value: index,
              child: Row(
                children: [
                  Icon(OrderStatusHelper.getStatusIcon(index), size: 18),
                  const SizedBox(width: 8),
                  Text(OrderStatusHelper.getStatusText(index)),
                ],
              ),
            );
          }),
        ],
        onChanged: (value) {
          if (value == null) {
            ordersBloc.add(FetchOrdersByCustomer());
          } else {
            ordersBloc.add(FetchOrdersByCustomerAndStatus(clientId, value));
          }
        },
      ),
    );
  }
}
