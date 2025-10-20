import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const Text(
          '\$15.99',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(width: 10),

        Text(
          '\$19.99',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade500,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
