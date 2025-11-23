import 'package:flutter/material.dart';
import 'package:smartcare/features/order/data/model/address_model/datum.dart';

class AddressCard extends StatelessWidget {
  final int index;
  final int selectedValue;
  final AddressDatum addressDatum;
  final ValueChanged<int> onSelect;

  const AddressCard({
    super.key,
    required this.index,
    required this.selectedValue,
    required this.addressDatum,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDefault = addressDatum.isPrimary ?? false;

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    children: [
                      Text(
                        addressDatum.address ?? "No Title",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),

                      if (isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF276BFE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Default",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    addressDatum.additionalInfo ?? "",
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
