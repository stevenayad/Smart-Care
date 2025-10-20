import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Profilecubit, Profilestate>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        if (state is Profilloading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProfileSuccess) {
          final profile = state.model;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.data?.userName ?? 'No Name',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              Text(
                profile.data?.email ?? 'No Email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3EDF7), Color(0xFFD7E4EF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      profile.data?.accountType ?? 'No Email',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.auto_awesome,
                      size: 16,
                      color: Color(0xFF3E4A59),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Text('No thing');
        }
      },
    );
  }
}
