import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/shimer_box.dart';

Widget buildCompanyShimmerList() {
  return SizedBox(
    height: 160,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: 6,
      itemBuilder: (context, index) => buildCompanyShimmerCard(),
    ),
  );
}

Widget buildCompanyShimmerCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6),
    width: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        shimmerBox(height: 45, width: 45, radius: 8),
        const SizedBox(height: 8),
        shimmerBox(height: 12, width: 70, radius: 6),
      ],
    ),
  );
}
