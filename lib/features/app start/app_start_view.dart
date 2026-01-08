import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/login_screen.dart';
import 'package:smartcare/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:smartcare/features/onboarding/presentation/onboardingview.dart';

class AppStartView extends StatelessWidget {
  const AppStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc()..add(CheckOnboardingEvent()),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingShow) {
            return const Onboardingview();
          }
          if (state is OnboardingFinished) {
            return const LoginScreen();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
