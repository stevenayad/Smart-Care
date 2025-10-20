import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_price.dart';
import 'package:smartcare/features/home/presentation/views/widget/rate&review.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Vitamin C 1000mg - 100 Tablets',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'HealthCo',
            style: TextStyle(fontSize: 14, color: Color(0xFF78909C)),
          ),
          const SizedBox(height: 10),
          Ratereview(),
          const SizedBox(height: 20),
          ProductPrice(),
          const SizedBox(height: 30),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Color(0xFFE0E0E0)),
          Text(
            'High-quality Vitamin C supplement to support your immune system and overall health. Each tablet contains 1000mg of pure ascorbic acid for maximum effectiveness.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
