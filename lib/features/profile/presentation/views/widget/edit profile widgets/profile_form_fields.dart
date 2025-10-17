import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_text_field.dart';

class ProfileFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dobController;

  const ProfileFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.dobController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditProfileTextField(
          label: 'First Name',
          controller: firstNameController,
          validator: (value) =>
              value == null || value.isEmpty ? 'First name required' : null,
        ),
        const SizedBox(height: 15),
        EditProfileTextField(
          label: 'Last Name',
          controller: lastNameController,
          validator: (value) =>
              value == null || value.isEmpty ? 'Last name required' : null,
        ),
        const SizedBox(height: 15),
        EditProfileTextField(
          label: 'Email Address',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Email required';
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            return emailRegex.hasMatch(value)
                ? null
                : 'Enter a valid email address';
          },
        ),
        const SizedBox(height: 15),
        EditProfileTextField(
          label: 'Phone Number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Phone number required';
            final phoneRegex = RegExp(r'^\+?\d[\d\s\-\(\)]{7,}$');
            return phoneRegex.hasMatch(value)
                ? null
                : 'Enter a valid phone number';
          },
        ),
        const SizedBox(height: 15),
        EditProfileTextField(
          label: 'Date of Birth',
          controller: dobController,
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
              dobController.text =
                  '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
            }
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'Date of birth required' : null,
        ),
      ],
    );
  }
}
