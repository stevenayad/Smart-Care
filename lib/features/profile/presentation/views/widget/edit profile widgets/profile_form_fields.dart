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

class ProfileFormFields extends StatefulWidget {
  const ProfileFormFields({super.key});

  @override
  State<ProfileFormFields> createState() => _ProfileFormFieldsState();
}

class _ProfileFormFieldsState extends State<ProfileFormFields> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final editprofilecubit = BlocProvider.of<Editprofilecubit>(context);

    return BlocBuilder<Profilecubit, Profilestate>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          final profile = state.model;

          int genderValue;
          switch (profile.data?.gender) {
            case 'NotPreferToSay':
              genderValue = 0;
              break;
            case 'Male':
              genderValue = 1;
              break;
            case 'Female':
              genderValue = 2;
              break;
            default:
              genderValue = 0;
          }

          int accountTypeValue;
          switch (profile.data?.accountType) {
            case 'SelfUse':
              accountTypeValue = 0;
              break;
            case 'FamilyUse':
              accountTypeValue = 1;
              break;
            default:
              accountTypeValue = 0;
          }

          if (!_initialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              editprofilecubit.firstNameController.text =
                  profile.data?.firstName ?? '';
              editprofilecubit.lastNameController.text =
                  profile.data?.lastName ?? '';
              editprofilecubit.usernameController.text =
                  profile.data?.userName ?? '';
              editprofilecubit.phoneController.text =
                  profile.data?.phoneNumber ?? '';
              editprofilecubit.dobController.text =
                  profile.data?.birthDate ?? '';
              editprofilecubit.gender = genderValue;
              editprofilecubit.accountType = accountTypeValue;

              editprofilecubit.emit(
                EditProfileGenderChanged(editprofilecubit.gender),
              );
              editprofilecubit.emit(
                EditProfileAccountTypeChanged(editprofilecubit.accountType),
              );

              _initialized = true;
            });
          }

          DateTime? initialDOB;
          try {
            if (editprofilecubit.dobController.text.isNotEmpty) {
              final parts = editprofilecubit.dobController.text.split('/');
              initialDOB = DateTime(
                int.parse(parts[2]),
                int.parse(parts[1]),
                int.parse(parts[0]),
              );
            }
          } catch (_) {
            initialDOB = DateTime(1990, 1, 1);
          }

          return Form(
            key: editprofilecubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
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
                      initialDate: initialDOB ?? DateTime(1990, 1, 1),
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
