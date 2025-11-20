import 'package:flutter/material.dart';
import '../../bloc/orders_event.dart';
import '../../bloc/orders_bloc.dart';
import 'order_status_helper.dart';

class OrderStatusFilter extends StatelessWidget {
  final String clientId;
  final OrdersBloc ordersBloc;

  const OrderStatusFilter({
    super.key,
    required this.clientId,
    required this.ordersBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DropdownButtonFormField<int?>(
        decoration: InputDecoration(
          labelText: 'Filter by Status',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        value: null, 
        items: [
          const DropdownMenuItem<int?>(
            value: null,
            child: Text('All'),
          ),
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
