import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/bestseller_favouriteitem.dart';
import 'package:smartcare/features/home/presentation/views/widget/common_section.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSection(
      isbestseller_favourotiteite: true,
      title: 'Best Sellers',
      items: const [
        BestsellerFavouriteitem(),
        BestsellerFavouriteitem(),
        BestsellerFavouriteitem(),
        BestsellerFavouriteitem(),
      ],
    );
  }
}

