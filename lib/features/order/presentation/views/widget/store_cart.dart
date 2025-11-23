import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/model/store_model/datum.dart';

class StoreCardOrder extends StatelessWidget {
  final int index;
  final int selectedValue;
  final StoreDatum store;
  final ValueChanged<int> onSelect;

  const StoreCardOrder({
    super.key,
    required this.index,
    required this.selectedValue,
    required this.store,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedValue == index
                ? const Color(0xFF276BFE)
                : const Color(0xFFE0E7F1),
            width: selectedValue == index ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: index,
              groupValue: selectedValue,
              activeColor: Colors.blue,
              onChanged: (_) => onSelect(index),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name ?? "No Name",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    store.address ?? "No address",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  if (store.phone != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      store.phone!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}