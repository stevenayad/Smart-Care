// FILE: features/auth/presentation/register/views/widgets/_step_2_details.dart

import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/custom_date_picker_field.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/custom_gender_selector.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class Step2Details extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController birthDateController;
  final int? gender;
  final ValueChanged<int?> onGenderChanged;

  const Step2Details({
    super.key,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.birthDateController,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomDatePickerField(
            controller: birthDateController,
            icon: Icons.calendar_today_outlined,
            label: 'Birth Date',
            hint: 'Select Birth Date',
            validator: (v) => v!.isEmpty ? 'Birth date is required' : null,
          ),
          const SizedBox(height: 20),
          CustomGenderSelector(groupValue: gender, onChanged: onGenderChanged),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: passwordController,
            icon: Icons.lock_outline,
            label: 'Password',
            hint: 'Password',
            isPassword: true,
            validator: (v) => v!.length < 6 ? 'Min 6 characters' : null,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: confirmPasswordController,
            icon: Icons.lock_reset_outlined,
            label: 'Confirm Password',
            hint: 'Confirm Password',
            isPassword: true,
            validator: (v) =>
                v != passwordController.text ? 'Passwords do not match' : null,
          ),
        ],
      ),
    );
  }
}
