import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/common_section.dart';
import 'package:smartcare/features/home/presentation/views/widget/gategory_brandsitem.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSection(
      isbestseller_favourotiteite: false,
      title: "Categories",
      onViewAllTap: () {},
      items: const [
        GategoryBrandsitem(image: "assets/image/drugs.png", text: "Vitameins"),
        GategoryBrandsitem(image: "assets/image/pain.png", text: "Pain Relief"),
        GategoryBrandsitem(
          image: "assets/image/first-aid-kit.png",
          text: "First Aid",
        ),
        GategoryBrandsitem(
          image: "assets/image/personal-hygiene.png",
          text: "Personal Care",
        ),
        GategoryBrandsitem(
          image: "assets/image/baby-boy.png",
          text: "Baby Care",
        ),
      ],
    );
  }
}
