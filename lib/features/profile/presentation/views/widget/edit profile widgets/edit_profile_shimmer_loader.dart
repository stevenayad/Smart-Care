import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class EditProfileShimmerLoader extends StatelessWidget {
  const EditProfileShimmerLoader({super.key});

  Widget shimmerBox({double height = 45, double width = double.infinity}) {
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
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Center(
            child: Shimmer(
              duration: const Duration(seconds: 2),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          shimmerBox(), // First Name
          const SizedBox(height: 15),
          shimmerBox(), // Last Name
          const SizedBox(height: 15),
          shimmerBox(), // Username
          const SizedBox(height: 15),
          shimmerBox(), // Phone
          const SizedBox(height: 15),
          shimmerBox(), // DOB
          const SizedBox(height: 20),
          shimmerBox(height: 40, width: 150), // Gender Title
          const SizedBox(height: 15),
          shimmerBox(height: 40, width: 200), // Account Type
          const SizedBox(height: 30),
          shimmerBox(height: 50), // Save button placeholder
        ],
      ),
    );
  }
}
