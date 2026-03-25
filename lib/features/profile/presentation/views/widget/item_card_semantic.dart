import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/data/Model/semantic_model/datum.dart';

class ItemCardSemantic extends StatelessWidget {
  final SemanticDatum item;

  const ItemCardSemantic({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 70,
              height: 70,
              child: Image.network(item.mainImageUrl ?? "", fit: BoxFit.cover),
            ),
          ),

          const SizedBox(width: 12),

          /// Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// name
                Text(
                  item.nameEn ?? "Unknown Product",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    /// rating
                    Icon(Icons.star, size: 14, color: Colors.orange),
                    Text(
                      "${item.averageRating ?? 0}",
                      style: const TextStyle(fontSize: 12),
                    ),

                    const SizedBox(width: 8),

                    /// availability
                    if (item.isAvailable == true)
                      const Text(
                        "Available",
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      )
                    else
                      const Text(
                        "Out of stock",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                  ],
                ),
              ],
            ),
          ),

          /// price + discount
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${item.price ?? 0} EGP",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              if (item.discountPercentage != null &&
                  item.discountPercentage! > 0)
                Text(
                  "-${item.discountPercentage}%",
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
