import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/forgot_password_screen.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_validator.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class LoginCardContent extends StatefulWidget {
  final bool isLoading;

  const LoginCardContent({super.key, required this.isLoading});

  @override
  State<LoginCardContent> createState() => _LoginCardContentState();
}

class _LoginCardContentState extends State<LoginCardContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    final errorMessage = LoginValidator.validateFields(
      email: email,
      password: password,
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

    context.read<AuthBloc>().add(
      LoginButtonPressed(email: email.trim(), password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // REMOVED: The Form widget wrapper is no longer needed.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text('Login', style: textTheme.titleLarge),
        Container(
          height: 2,
          width: 80,
          color: colorScheme.surface,
          margin: const EdgeInsets.only(top: 4, bottom: 30),
        ),
        CustomTextFormField(
          controller: _emailController,
          label: 'Email Address',
          hint: 'Email Address',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: _passwordController,
          label: 'Password',
          hint: 'Password',
          icon: Icons.lock_outline,
          isPassword: true,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 25),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot Password?',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.surface,
                  decoration: TextDecoration.underline,
                  decorationColor: colorScheme.surface,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: widget.isLoading
              ? const CircularProgressIndicator()
              : CustomElevatedButton(
                  text: 'Login',
                  onPressed: _onLogin,
                  elevation: 10,
                ),
        ),
      ],
    );
  }
}
