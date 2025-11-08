import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/Favourite/presentation/views/widgets/Favourite_body.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context, 'Favourite', null, null),
      body: FavouriteBody(),
    );
  }
}
