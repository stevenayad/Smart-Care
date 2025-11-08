import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/detials_product_model/detials_product_model.dart';

class ProductPrice extends StatelessWidget {
  final DetialsProductModel detialsProductModel;
  const ProductPrice({super.key, required this.detialsProductModel});

  @override
  Widget build(BuildContext context) {
    final price = detialsProductModel.data?.price ?? 0;
    final discount = detialsProductModel.data?.discountPercentage ?? 0.0;
    final discountedPrice = price - (price * (discount / 100));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '${discountedPrice.toStringAsFixed(0)} EGP',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(width: 10),

        const SizedBox(width: 10),

        if (discount > 0)
          Text(
            '${discount.toStringAsFixed(0)}% OFF',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
