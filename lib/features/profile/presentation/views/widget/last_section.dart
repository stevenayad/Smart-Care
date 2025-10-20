import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/address_screen.dart';
import 'package:smartcare/features/profile/presentation/views/edit_profile_screen.dart';

import 'package:smartcare/features/profile/presentation/views/widget/build_navagationtitle.dart';

class LastSection extends StatelessWidget {
  const LastSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          buildNavagationtitle(
            context,
            'Edit Profile',
            Icons.edit,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Change Password',
            Icons.lock_outline,
            onTap: () {},
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'My Orders',
            Icons.shopping_bag_outlined,
            onTap: () {},
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Address',
            Icons.location_on_outlined,
            onTap: () {
              print('💡 Address tapped');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressScreen()),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Payment Methods',
            Icons.payment,
            onTap: () {},
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Favorites',
            Icons.favorite_border,
            onTap: () {},
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Cart',
            Icons.shopping_cart_outlined,
            onTap: () {},
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Settings',
            Icons.settings,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
