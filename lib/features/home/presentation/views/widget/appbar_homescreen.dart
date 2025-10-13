import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class AppbarHomescreen extends StatelessWidget {
  const AppbarHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLightColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image/medical-report.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  'Smart Care',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, size: 25),
                  onPressed: () {},
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    child: Text(
                      '3',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
