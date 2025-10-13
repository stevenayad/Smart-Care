import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/action_item.dart';

class AcationSection extends StatelessWidget {
  const AcationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionItem(text: 'Orders', number: '12', icon: Icons.shopping_bag),
          ActionItem(
            text: 'Favorites',
            number: '8',
            icon: Icons.favorite_border,
          ),
          ActionItem(text: 'Reviews', number: '5', icon: Icons.rate_review),
        ],
      ),
    );
  }
}
