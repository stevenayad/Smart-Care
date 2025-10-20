import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_text_field.dart';

class ProfileFormFields extends StatelessWidget {
  const ProfileFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final editprofilecubit = BlocProvider.of<Editprofilecubit>(context);
    return BlocBuilder<Profilecubit, Profilestate>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          final profile = state.model;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            editprofilecubit.firstNameController.text = 'Steven';
            editprofilecubit.lastNameController.text = 'Ayad';
            editprofilecubit.usernameController.text =
                profile.data?.userName ?? '';
            editprofilecubit.emailController.text =
                profile.data?.email ?? 'No Email';
            editprofilecubit.phoneController.text = '01204615216';
            editprofilecubit.dobController.text = profile.data?.birthDate ?? '';
          });

          return Column(
            children: [
              EditProfileTextField(
                label: 'First Name',
                controller: editprofilecubit.firstNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'First name required'
                    : null,
              ),
              const SizedBox(height: 15),
              EditProfileTextField(
                label: 'Last Name',
                controller: editprofilecubit.lastNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Last name required'
                    : null,
              ),
              const SizedBox(height: 15),
              EditProfileTextField(
                label: 'User Name',
                controller: editprofilecubit.usernameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'User name required'
                    : null,
              ),
              const SizedBox(height: 15),
              EditProfileTextField(
                label: 'Email Address',
                controller: editprofilecubit.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email required';
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  return emailRegex.hasMatch(value)
                      ? null
                      : 'Enter a valid email address';
                },
              ),
              const SizedBox(height: 15),
              EditProfileTextField(
                label: 'Phone Number',
                controller: editprofilecubit.phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Phone number required';
                  final phoneRegex = RegExp(r'^\+?\d[\d\s\-\(\)]{7,}$');
                  return phoneRegex.hasMatch(value)
                      ? null
                      : 'Enter a valid phone number';
                },
              ),
              const SizedBox(height: 15),
              EditProfileTextField(
                label: 'Date of Birth',
                controller: editprofilecubit.dobController,
                readOnly: true,
                suffixIcon: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1990, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    editprofilecubit.dobController.text =
                        '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                  }
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Date of birth required'
                    : null,
              ),
            ],
          );
        }
        if (state is Profilloading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileFailure) {
          return Center(child: Text('Failed to load Edit profile'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
