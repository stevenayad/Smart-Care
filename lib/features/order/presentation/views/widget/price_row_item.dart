import 'package:flutter/material.dart';

class PriceRowItem extends StatelessWidget {
  const PriceRowItem({
    super.key,
    required this.title,
    required this.value,
    this.isBold = false,
  });

  final String title;
  final double value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          '${value.toStringAsFixed(2)} EGP',
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}