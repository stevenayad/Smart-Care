import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';

Widget buildInfoSection(DetailsProductModel model) {
  final companyName = model.data?.companyName ?? "Unknown Company";
  final rating = model.data?.totalRatings?.toStringAsFixed(1) ?? "0.0";

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Row(
          children: [
            Icon(
              Icons.store_mall_directory,
              color: Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              companyName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              rating,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
