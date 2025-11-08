import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/home/presentation/views/widget/appbar_homescreen.dart';
import 'package:smartcare/features/home/presentation/views/widget/best_seller.dart';
import 'package:smartcare/features/home/presentation/views/widget/gategory.dart';
import 'package:smartcare/features/home/presentation/views/widget/popular_brand.dart';
import 'package:smartcare/features/home/presentation/views/widget/search_appbar.dart';
import 'package:smartcare/features/home/presentation/views/widget/yourfavourite.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primaryLightColor,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Column(
                children: [AppbarHomescreen(), SearchBarWidget()],
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Category(),
                  SizedBox(height: 20),
                  PopularBrand(),
                  SizedBox(height: 10),
                  BestSeller(),
                  SizedBox(height: 10),
                  Yourfavourite(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
