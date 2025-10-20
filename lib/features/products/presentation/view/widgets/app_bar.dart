import 'package:flutter/material.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/custom_appbar.dart';

class AppBarr extends StatelessWidget implements PreferredSizeWidget {
  const AppBarr({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Products",
      badgeCount: 3,
      actionIcon: Icons.shopping_cart,
      onAction: () {},
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
