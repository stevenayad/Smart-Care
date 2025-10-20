import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class AddCartbutton extends StatelessWidget {
  const AddCartbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
          label: Text(
            'Add To Cart',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mediumGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
