import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/details_product_model/details_product_model.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.detailsProductModel});
  final DetailsProductModel detailsProductModel;

  @override
  Widget build(BuildContext context) {
    final price = detailsProductModel.data?.price ?? 0;
    final discount = detailsProductModel.data?.discountPercentage ?? 0.0;
    final discountedPrice = price - (price * (discount / 100));
    return Row(
      children: [
        Text(
          '${discountedPrice.toStringAsFixed(2)} EGP',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${price.toStringAsFixed(2)} EGP',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade500,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "${discount.toStringAsFixed(0)}% OFF",
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF009688),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
