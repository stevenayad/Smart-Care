import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/auth_cubit/authcubit_cubit.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/home/presentation/views/main_screen_view.dart';
import 'package:smartcare/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:smartcare/features/onboarding/presentation/onboardingview.dart';
import 'package:smartcare/features/auth/presentation/Manager/request_bloc/request_bloc.dart';

class AppStartView extends StatelessWidget {
  const AppStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc()..add(CheckOnboardingEvent()),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, onboardingState) {

          /// 🟡 لو لسه Onboarding
          if (onboardingState is OnboardingShow) {
            return const Onboardingview();
          }

          /// 🟢 لو خلص Onboarding → نشوف Auth
          if (onboardingState is OnboardingFinished) {
            return BlocBuilder<AuthCubit, AuthcubitState>(
              builder: (context, authState) {

                if (authState is Authenticated) {
                  return const MainScreenView(); // 👈 المستخدم داخل
                }

                if (authState is Unauthenticated) {
                  return const LoginScreen(); // 👈 مش داخل
                }

                /// loading
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          }

          /// loading مبدئي
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}