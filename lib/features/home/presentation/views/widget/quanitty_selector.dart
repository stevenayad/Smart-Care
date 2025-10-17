import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.remove, color: Color(0xFF546E7A)),
            splashRadius: 20,
          ),
          const Text(
            '2',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.add, color: Color(0xFF546E7A)),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
