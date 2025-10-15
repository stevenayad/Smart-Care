import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/common_section.dart';
import 'package:smartcare/features/home/presentation/views/widget/gategory_brandsitem.dart';

class PopularBrand extends StatelessWidget {
  const PopularBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSection(
      isbestseller_favourotiteite: false,
      title: "Popular Brands",
      onViewAllTap: () {},
      items: const [
        GategoryBrandsitem(image: "assets/image/bayer.png", text: "Pfizer"),
        GategoryBrandsitem(image: "assets/image/bayer.png", text: "Johnson"),
        GategoryBrandsitem(image: "assets/image/bayer.png", text: "Bayer"),
        GategoryBrandsitem(image: "assets/image/bayer.png", text: "Merck"),
        GategoryBrandsitem(image: "assets/image/bayer.png", text: "Novatris"),
      ],
    );
  }
}
