import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart'; 
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/bottom_widget.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/line_with_or.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_card_content.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_card_painter.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/social_icon_button.dart';
import 'package:smartcare/features/auth/presentation/widgets/header.dart';
import 'package:smartcare/features/home/presentation/views/home_screen.dart';
import 'package:smartcare/features/products/presentation/view/products_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Successful!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ProductsScreen()),
              );
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
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                children: [
                  const Header(),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double cardWidth = constraints.maxWidth;
                      double cardHeight = 380.0;

                      return SizedBox(
                        width: cardWidth,
                        height: cardHeight,
                        child: CustomPaint(
                          painter: LoginCardPainter(
                            AppThemes.lightTheme.primaryColor,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: LoginCardContent(isLoading: isLoading),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const LineWithOr(),
                  const SizedBox(height: 20),
                  const SocialIconButton(),
                  const SizedBox(height: 20),
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