import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/logic_login_cubit/logic_login_cubit.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/forgot_password_screen.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_text_feild.dart';

class LoginCardContent extends StatelessWidget {
  const LoginCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<LoginCubit>().clearErrorMessage();
        }
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text('Login', style: textTheme.titleLarge),
            Container(
              height: 2,
              width: 90,
              color: colorScheme.surface,
              margin: const EdgeInsets.only(top: 4, bottom: 30),
            ),
            CustomTextFormField(
              label: 'Email Address',
              hint: 'Email Address',
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              onChanged: cubit.onEmailChanged,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Password',
              hint: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
              onChanged: cubit.onPasswordChanged,
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
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 150,
                      child: CustomElevatedButton(
                        text: 'Login',
                        onPressed: cubit.onLoginPressed,
                        elevation: 10,
                        borderRadius: 40,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

