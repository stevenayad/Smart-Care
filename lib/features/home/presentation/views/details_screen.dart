import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_body.dart';
import 'package:smartcare/features/home/presentation/views/widget/details_navagationbar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context, 'Product Details', null, [
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      ]),
      body: DetailsBody(),
      bottomNavigationBar: DetailsNavagationbar(),
    );
  }
}
