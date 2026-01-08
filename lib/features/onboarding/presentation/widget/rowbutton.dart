import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/register/views/register_page.dart'
    show RegisterScreen;
import 'package:smartcare/features/onboarding/presentation/bloc/onboarding_bloc.dart';

class Rowbutton extends StatelessWidget {
  final bool isDark;
  final int currentIndex;
  final int itemsLength;
  final PageController pageController;

  const Rowbutton({
    super.key,
    required this.isDark,
    required this.currentIndex,
    required this.itemsLength,
    required this.pageController,
  });
  void _finishOnboarding(BuildContext context) {
    context.read<OnboardingBloc>().add(CompleteOnboardingEvent());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              _finishOnboarding(context);
            },
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black54,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (currentIndex < itemsLength - 1) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                _finishOnboarding(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              currentIndex < itemsLength - 1 ? 'Next' : 'Get Started',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
