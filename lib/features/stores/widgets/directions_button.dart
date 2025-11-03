import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart'; 

class DirectionsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DirectionsButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.near_me_outlined, size: 18),
        label: const Text('Get Directions'),
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mediumGrey,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
