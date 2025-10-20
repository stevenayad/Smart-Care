import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/widget/check_store.dart';
import 'package:smartcare/features/home/presentation/views/widget/image_details.dart';
import 'package:smartcare/features/home/presentation/views/widget/product_details.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [ImageDetails(), ProductDetails(), CheckStore()]),
    );
  }
}
