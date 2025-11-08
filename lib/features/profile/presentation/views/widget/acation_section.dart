import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';
import 'package:smartcare/features/profile/presentation/views/widget/action_item.dart';

class AcationSection extends StatelessWidget {
  const AcationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<Profilecubit, Profilestate>(
        builder: (context, state) {
          if (state is Profilloading) {
            // ✅ Shimmer effect during profile loading
            return Shimmer(
              duration: const Duration(seconds: 2),
              interval: const Duration(seconds: 1),
              color: Colors.grey.shade300,
              colorOpacity: 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(width: 60, height: 12, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(width: 20, height: 12, color: Colors.white),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is ProfileSuccess) {
            final profile = state.model;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionItem(
                  text: 'Orders',
                  number: profile.data?.ordersCount ?? 0,
                  icon: Icons.shopping_bag,
                ),
                ActionItem(
                  text: 'Favorites',
                  number: profile.data?.favoritesCount ?? 0,
                  icon: Icons.favorite_border,
                ),
                ActionItem(
                  text: 'Reviews',
                  number: profile.data?.ratesCount ?? 0,
                  icon: Icons.rate_review,
                ),
              ],
            );
          }

          if (state is ProfileFailure) {
            return const Text('Failed to load data');
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
