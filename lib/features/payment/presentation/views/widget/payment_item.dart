import 'package:flutter/material.dart';
import 'package:smartcare/features/payment/data/Model/payment_method.dart';

class PaymentItem extends StatelessWidget {
  final PaymentMethod method;
  final VoidCallback onTap;

  const PaymentItem({super.key, required this.method, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: method.isSelected,
              onChanged: (_) => onTap(),
              activeColor: const Color(0xFF0066FF),
            ),

            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: method.image != null
                    ? Image.network(method.image!, width: 24)
                    : Icon(
                        method.icon,
                        size: 26,
                        color: const Color(0xFF0066FF),
                      ),
              ),
            ),

            const SizedBox(width: 16),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  method.subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
