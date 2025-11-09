import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/Favourite/presentation/views/favourites_screen.dart';
import 'package:smartcare/features/home/presentation/cubits/navgatie/navigationcubit%20.dart';
import 'package:smartcare/features/home/presentation/views/home_screen.dart';
import 'package:smartcare/features/home/presentation/views/widget/custom_navagation_bar.dart';
import 'package:smartcare/features/products/presentation/view/products_screen.dart';
import 'package:smartcare/features/profile/presentation/views/profile_screen.dart';
import 'package:smartcare/features/stores/presentation/screens/store_screen.dart';

class Mainscreenview extends StatelessWidget {
  const Mainscreenview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: const [
                HomeScreen(),
                ProductsScreen(),
                StoreScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
