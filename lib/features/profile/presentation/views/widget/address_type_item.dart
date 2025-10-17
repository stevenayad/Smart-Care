import 'package:flutter/material.dart';

class AddressTypeItem extends StatelessWidget {
  final IconData icons;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  const AddressTypeItem({
    super.key,
    required this.icons,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade400,
              width: isSelected ? 1.8 : 0.6,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icons, color: isSelected ? Colors.blue : Colors.black54),
                const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.blue : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
