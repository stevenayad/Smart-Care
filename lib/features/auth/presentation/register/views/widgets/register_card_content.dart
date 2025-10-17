import 'package:flutter/material.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_validator.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class RegisterCardContent extends StatefulWidget {
  const RegisterCardContent({super.key});

  @override
  State<RegisterCardContent> createState() => _RegisterCardContentState();
}

class _RegisterCardContentState extends State<RegisterCardContent> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    final errorMessage = RegisterValidator.validateFields(
      username: _usernameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registering user...'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text('Register', style: textTheme.titleLarge),
          Container(
            height: 2,
            width: 120,
            color: AppThemes.lightTheme.colorScheme.surface,
            margin: const EdgeInsets.only(top: 4, bottom: 30),
          ),
          const SizedBox(height: 30),

          // Username
          CustomTextFormField(
            label: 'Username',
            hint: "Username",
            icon: Icons.person_outline,
            controller: _usernameController,
          ),
          const SizedBox(height: 20),

          // Phone
          CustomTextFormField(
            label: 'Phone Number',
            hint: "Phone Number",
            icon: Icons.phone_outlined,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),

          // Email
          CustomTextFormField(
            label: 'Email Address',
            hint: "Email Address",
            icon: Icons.mail_outline,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),

          // Password
          CustomTextFormField(
            label: 'Password',
            hint: "Password",
            icon: Icons.lock_outline,
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 20),

          // Confirm Password
          CustomTextFormField(
            label: 'Confirm Password',
            hint: "Confirm Password",
            icon: Icons.lock_reset_outlined,
            controller: _confirmPasswordController,
            isPassword: true,
          ),
          const SizedBox(height: 30),

          // Register Button
          Center(
            child: CustomElevatedButton(
              text: 'Register',
              onPressed: _onRegister,
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }
}
