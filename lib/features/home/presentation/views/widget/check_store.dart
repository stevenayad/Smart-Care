import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class CheckStore extends StatelessWidget {
  const CheckStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryLightColor,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_sharp, size: 12),
              Text(
                'Check Availabliity in Store',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
