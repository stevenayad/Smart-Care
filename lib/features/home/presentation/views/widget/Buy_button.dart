import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Buy',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
