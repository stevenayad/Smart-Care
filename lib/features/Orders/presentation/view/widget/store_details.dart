import 'package:flutter/material.dart';

class StoreDetailsWidget extends StatelessWidget {
  final dynamic store;

  const StoreDetailsWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${store.name}"),
          Text("Address: ${store.address}"),
          Text("Phone: ${store.phone}"),
        ],
      ),
    );
  }
}