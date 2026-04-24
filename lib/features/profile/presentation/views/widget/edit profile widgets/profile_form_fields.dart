import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilestate.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_account_type.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_text_field.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_shimmer_loader.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit_profile_gender_selection.dart';
class ProfileFormFields extends StatelessWidget {
  const ProfileFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<Editprofilecubit>();

    return BlocBuilder<Profilecubit, Profilestate>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
       
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.initializeFromProfile(state);
          });

          return Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                EditProfileTextField(
                  label: 'First Name',
                  controller: cubit.firstNameController,
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? 'First name required'
                          : null,
                ),

                const SizedBox(height: 15),

                EditProfileTextField(
                  label: 'Last Name',
                  controller: cubit.lastNameController,
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Last name required'
                          : null,
                ),

                const SizedBox(height: 15),

                EditProfileTextField(
                  label: 'User Name',
                  controller: cubit.usernameController,
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? 'User name required'
                          : null,
                ),

                const SizedBox(height: 15),

                EditProfileTextField(
                  label: 'Phone Number',
                  controller: cubit.phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Phone number required';

                    final phoneRegex =
                        RegExp(r'^\+?\d[\d\s\-\(\)]{7,}$');

                    return phoneRegex.hasMatch(value)
                        ? null
                        : 'Enter a valid phone number';
                  },
                ),

                const SizedBox(height: 15),

                EditProfileTextField(
                  label: 'Date of Birth',
                  controller: cubit.dobController,
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: cubit.getInitialDOB(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      cubit.dobController.text =
                          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                    }
                  },
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Date of birth required'
                          : null,
                ),

                const SizedBox(height: 20),
                const EditProfileGenderSelection(),
                const SizedBox(height: 15),
                const EditProfileAccountType(),
              ],
            ),
          );
        }

        if (state is Profilloading) {
          return const EditProfileShimmerLoader();
        }

        if (state is ProfileFailure) {
          return const Center(
            child: Text('❌ Failed to load profile. Please try again.'),
          );
        }

        return const EditProfileShimmerLoader();
      },
    );
  }
}