import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/shimer_box.dart';

Widget buildShimmerGrid() {
  return GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1.1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: 6,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          shimmerBox(height: 100, width: double.infinity, radius: 12),
          const SizedBox(height: 10),
          shimmerBox(height: 14, width: 80, radius: 6),
        ],
      );
    },
  );
}
