
import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/custom_date_picker_field.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/custom_gender_selector.dart';

import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class PersonalInfoForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController birthDateController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final int? gender;
  final ValueChanged<int?> onGenderChanged;

  const PersonalInfoForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
    required this.birthDateController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
            controller: firstNameController,
            icon: Icons.person_outline,
            label: 'First Name',
            hint: 'First Name',
            validator: (v) => v!.isEmpty ? 'Required' : null),
        const SizedBox(height: 20),
        CustomTextFormField(
            controller: lastNameController,
            icon: Icons.person_outline,
            label: 'Last Name',
            hint: 'Last Name',
            validator: (v) => v!.isEmpty ? 'Required' : null),
        const SizedBox(height: 20),
        CustomTextFormField(
            controller: usernameController,
            icon: Icons.alternate_email,
            label: 'Username',
            hint: 'Username',
            validator: (v) => v!.isEmpty ? 'Required' : null),
        const SizedBox(height: 20),
        CustomTextFormField(
            controller: phoneController,
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            hint: 'Phone Number',
            keyboardType: TextInputType.phone,
            validator: (v) => v!.isEmpty ? 'Required' : null),
        const SizedBox(height: 20),
        CustomTextFormField(
            controller: emailController,
            icon: Icons.mail_outline,
            label: 'Email Address',
            hint: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v!.isEmpty ? 'Required' : null),
        const SizedBox(height: 20),
        CustomDatePickerField(
            controller: birthDateController,
            icon: Icons.calendar_today_outlined,
            label: 'Birth Date',
            hint: 'Select Birth Date',
            validator: (v) => v!.isEmpty ? 'Required' : null),
        const SizedBox(height: 20),
        CustomGenderSelector(
          groupValue: gender,
          onChanged: onGenderChanged,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
            controller: passwordController,
            icon: Icons.lock_outline,
            label: 'Password',
            hint: 'Password',
            isPassword: true,
            validator: (v) => v!.length < 6 ? 'Min 6 characters' : null),
        const SizedBox(height: 20),
        CustomTextFormField(
            controller: confirmPasswordController,
            icon: Icons.lock_reset_outlined,
            label: 'Confirm Password',
            hint: 'Confirm Password',
            isPassword: true,
            validator: (v) =>
                v != passwordController.text ? 'Passwords mismatch' : null),
      ],
    );
  }
}