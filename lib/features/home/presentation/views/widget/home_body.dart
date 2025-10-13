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
    return Column(
      children: [
        Container(
          color: AppColors.primaryLightColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(children: [AppbarHomescreen(), SearchBarWidget()]),
          ),
        ),

        Expanded(
          child: ListView(
            children: [
              Category(),
              PopularBrand(),
              BestSeller(),
              Yourfavourite(),
            ],
          ),
        ),
      ],
    );
  }
}
