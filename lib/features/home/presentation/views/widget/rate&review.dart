import 'package:flutter/material.dart';

class Ratereview extends StatelessWidget {
  const Ratereview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
        const SizedBox(width: 5),
        const Text(
          '4.8',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Text(
          '(234 reviews)',
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
