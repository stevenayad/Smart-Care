import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';

class EditProfileImagePicker extends StatelessWidget {
  const EditProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editCubit = context.watch<Editprofilecubit>();

    return BlocBuilder<Profilecubit, Profilestate>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: colorScheme.primary.withOpacity(0.2),
                    backgroundImage: editCubit.profileImage != null
                        ? FileImage(editCubit.profileImage!)
                        : NetworkImage(state.model.data?.profileImageUrl ?? "")
                              as ImageProvider,
                  ),

                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: GestureDetector(
                      onTap: () => BlocProvider.of<Editprofilecubit>(
                        context,
                      ).pickImage(),
                      child: CircleAvatar(
                        backgroundColor: colorScheme.primary,
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt,
                          color: colorScheme.surface,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Tap to change photo',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
