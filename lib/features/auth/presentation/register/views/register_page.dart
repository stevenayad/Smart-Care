import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/bottom_widget.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_card_content.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_cart_painter.dart';
import 'package:smartcare/features/auth/presentation/widgets/header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration Successful!'),
                  backgroundColor: Colors.green,
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              });
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  const Header(),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        height: 850.0,
                        child: CustomPaint(
                          painter: RegisterCardPainter(
                            AppThemes.lightTheme.primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                            ),

                            child: RegisterCardContent(isLoading: isLoading),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const BottomWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
