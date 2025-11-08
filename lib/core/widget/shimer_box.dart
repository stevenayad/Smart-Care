import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

Widget shimmerBox({double height = 14, double width = 120, double radius = 6}) {
  return Shimmer(
    duration: const Duration(seconds: 2),
    interval: const Duration(seconds: 4),
    color: Colors.grey.shade300,
    colorOpacity: 0.5,
    direction: const ShimmerDirection.fromLTRB(),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}
