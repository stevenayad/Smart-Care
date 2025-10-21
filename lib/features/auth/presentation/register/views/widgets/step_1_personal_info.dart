import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/profile_imagepicker.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class Step1PersonalInfo extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final XFile? profileImage;
  final VoidCallback onPickImage;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const Step1PersonalInfo({
    super.key,
    required this.formKey,
    required this.profileImage,
    required this.onPickImage,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          ProfileImagePicker(image: profileImage, onPickImage: onPickImage),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: firstNameController,
            icon: Icons.person_outline,
            label: 'First Name',
            hint: 'First Name',
            validator: (v) => v!.isEmpty ? 'First name is required' : null,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: lastNameController,
            icon: Icons.person_outline,
            label: 'Last Name',
            hint: 'Last Name',
            validator: (v) => v!.isEmpty ? 'Last name is required' : null,
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            controller: usernameController,
            icon: Icons.account_circle_outlined,
            label: 'Username',
            hint: 'Enter your username',
            validator: (v) => v!.isEmpty ? 'Username is required' : null,
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            controller: emailController,
            icon: Icons.mail_outline,
            label: 'Email Address',
            hint: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v!.isEmpty ? 'Email is required' : null,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: phoneController,
            icon: Icons.phone,
            label: 'phone your phone',
            hint: 'Enter your phone',
            keyboardType: TextInputType.number,
            validator: (v) => v!.isEmpty ? 'your phone is required' : null,
          ),
        ],
      ),
    );
  }
}
