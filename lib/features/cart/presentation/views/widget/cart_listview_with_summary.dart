import 'package:flutter/material.dart';
import 'package:smartcare/features/cart/data/model/items_cart/datum.dart';
import 'cartitem.dart';
import 'order_info_section.dart';

class CartListWithSummary extends StatelessWidget {
  final List<DatumCart> items;

  const CartListWithSummary({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index < items.length) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Cartitem(item: items[index]),
          );
        } else {
          return const OrderInfoSection();
        }
      },
    );
  }
}
