import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smartcare/core/api/services/app_signalr_services.dart' show AppSignalRService;
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/features/home/presentation/cubits/navgatie/navigationcubit%20.dart';

import 'package:smartcare/features/home/presentation/views/home_screen.dart';
import 'package:smartcare/features/products/presentation/view/products_screen.dart';
import 'package:smartcare/features/stores/presentation/screens/store_screen.dart';
import 'package:smartcare/features/profile/presentation/views/profile_screen.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    
  final signalRService = AppSignalRService(CacheHelper.getAccessToken() ?? "");
  signalRService.init();
  
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
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2F3142),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (index) {
                  IconData iconData;
                  switch (index) {
                    case 0:
                      iconData = LineIcons.home;
                      break;
                    case 1:
                      iconData = LineIcons.boxOpen;
                      break;
                    case 2:
                      iconData = LineIcons.store;
                      break;
                    case 3:
                      iconData = LineIcons.userAlt;
                      break;
                    default:
                      iconData = LineIcons.user;
                  }

                  bool isSelected = currentIndex == index;

                  return GestureDetector(
                    onTap: () =>
                        context.read<NavigationCubit>().changeIndex(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: 3,
                          width: 20,
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Icon(
                          iconData,
                          color: isSelected ? Colors.blue : Colors.grey,
                          size: 28,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
