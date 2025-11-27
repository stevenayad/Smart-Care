import 'package:flutter/material.dart';
import 'package:smartcare/features/Favourite/presentation/views/favourites_screen.dart';
import 'package:smartcare/features/Orders/presentation/view/widget/orders_bloc_provider.dart';
import 'package:smartcare/features/cart/presentation/views/cart_screen.dart';
import 'package:smartcare/features/profile/presentation/views/address_screen.dart';
import 'package:smartcare/features/profile/presentation/views/change_password_screen.dart';
import 'package:smartcare/features/profile/presentation/views/edit_profile_screen.dart';

import 'package:smartcare/features/profile/presentation/views/widget/build_navagationtitle.dart';
import 'package:smartcare/features/settings/presentation/views/setting_screen.dart';

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'My Orders',
            Icons.shopping_bag_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => buildOrdersBlocScreen(),
                ),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Address',
            Icons.location_on_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressScreen()),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Favorites',
            Icons.favorite_border,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavouritesScreen()),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Cart',
            Icons.shopping_cart_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          Divider(thickness: 0.5),
          buildNavagationtitle(
            context,
            'Settings',
            Icons.settings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
