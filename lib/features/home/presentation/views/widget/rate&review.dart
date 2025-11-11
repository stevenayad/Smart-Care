import 'package:flutter/material.dart';
import 'package:smartcare/features/home/data/Model/detials_product_model/detials_product_model.dart';

class Rate extends StatelessWidget {
  const Rate({super.key, required this.detialsProductModel});
  final DetialsProductModel detialsProductModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
        const SizedBox(width: 5),
        Text(
          detialsProductModel.data?.totalRatings.toString() ?? '',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
