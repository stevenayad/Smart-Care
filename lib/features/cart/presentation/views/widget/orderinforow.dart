import 'package:flutter/material.dart';

class Orderinforow extends StatelessWidget {
  const Orderinforow({
    super.key,
    required this.text,
    required this.value,
    this.bold = false,
  });

  final String text, value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final double fontSize = bold ? 17 : 17;
    final FontWeight fontWeight = bold ? FontWeight.w600 : FontWeight.normal;
    final Color color = bold ? Colors.black : Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: bold ? Colors.black : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
