import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';
import 'package:smartcare/features/profile/presentation/views/widget/action_item.dart';

class AcationSection extends StatelessWidget {
  const AcationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocBuilder<Profilecubit, Profilestate>(
        builder: (context, state) {
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
          } else {
            return Text('No thing');
          }
        },
      ),
    );
  }
}
