import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/Buy_button.dart';
import 'package:smartcare/features/home/presentation/views/widget/add_cartbutton.dart';
import 'package:smartcare/features/home/presentation/views/widget/quanitty_selector.dart';

class DetailsNavagationbar extends StatelessWidget {
  const DetailsNavagationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuantitySelector(),
          const SizedBox(width: 2),
          AddCartbutton(),
          const SizedBox(width: 2),
          BuyButton(),
        ],
      ),
    );
  }
}
