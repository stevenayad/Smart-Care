import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart'
    show AppSignalRService;
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/home/presentation/cubits/navgatie/navigationcubit%20.dart';
import 'package:smartcare/features/home/presentation/views/home_screen.dart';
import 'package:smartcare/features/products/presentation/view/products_screen.dart';
import 'package:smartcare/features/stores/presentation/screens/store_screen.dart';
import 'package:smartcare/features/profile/presentation/views/profile_screen.dart';
import 'package:smartcare/core/app_color.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartCubit = context.read<CartCubit>();
      if (cartCubit.cartId == null) {
        cartCubit.makecart();
      } else if (cartCubit.cartId != null) {
        cartCubit.GetITem(cartCubit.cartId ?? "");
      }
    });
    // final signalRService = AppSignalRService(
    //   CacheHelper.getAccessToken() ?? "",
    // );
    // signalRService.init();

    final List<Widget> _screens = const [
      HomeScreen(),
      ProductsScreen(),
      StoreScreen(),
      ProfileScreen(),
    ];

    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(index: currentIndex, children: _screens),
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.reactCircle,
              backgroundColor: AppColors.primaryblue,
              color: AppColors.white,
              elevation: 12,
              curveSize: 90,
              height: 65,
              initialActiveIndex: currentIndex,
              onTap: (index) =>
                  context.read<NavigationCubit>().changeIndex(index),
              activeColor: Colors.white,
              gradient: LinearGradient(
                colors: [AppColors.accentGreen, AppColors.primaryLightColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              items: const [
                TabItem(icon: LineIcons.home, title: 'Home'),
                TabItem(icon: LineIcons.boxOpen, title: 'Products'),
                TabItem(icon: LineIcons.store, title: 'Stores'),
                TabItem(icon: LineIcons.userAlt, title: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}
