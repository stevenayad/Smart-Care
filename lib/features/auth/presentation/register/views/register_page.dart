import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/auth/presentation/Bloc/auth_bloc/auth_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/bottom_widget.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_card.dart';
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
                  content: Text('Registration Successful! Please log in.'),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
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
          builder: (context, authState) {
            final isLoading = authState is AuthLoading;

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accentGreen, AppColors.lightGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.5], // Blend nicely
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    const Header()
                        .animate()
                        .fadeIn(duration: 900.ms, delay: 200.ms)
                        .slideY(begin: -0.2, end: 0),
                    const SizedBox(height: 10),

                    register_card(isLoading: isLoading)
                        .animate()
                        .fadeIn(duration: 900.ms, delay: 400.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 30),
                    const BottomWidget()
                        .animate()
                        .fadeIn(duration: 900.ms, delay: 600.ms)
                        .slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
