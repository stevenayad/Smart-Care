import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/auth/presentation/Bloc/steps_bloc/steps_bloc.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/step_navigator.dart';

class RegisterFormLayout extends StatelessWidget {
  final StepsState state;
  final bool isLoading;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onRegister;
  final Widget stepContent; // The widget for the current step

  const RegisterFormLayout({
    super.key,
    required this.state,
    required this.isLoading,
    required this.onNext,
    required this.onBack,
    required this.onRegister,
    required this.stepContent,
  });

  // Step titles are a UI concern, so they live here now
  final List<String> _stepTitles = const [
    'Personal Information',
    'Account Details',
    'Your Address',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconStepper(
          icons: const [
            Icon(Icons.person_outline),
            Icon(Icons.assignment_outlined),
            Icon(Icons.location_on_outlined),
          ],
          activeStep: state.currentStep,
          activeStepColor: AppColors.primaryblue,
          stepColor: Colors.grey.shade400,
          scrollingDisabled: true,
          lineColor: Colors.grey.shade300,
          stepReachedAnimationEffect: Curves.easeInOut,
          enableNextPreviousButtons: false,
        ),
        const SizedBox(height: 24),

        // Animated Title
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.2), // Slide up
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            _stepTitles[state.currentStep],
            key: ValueKey(state.currentStep), // CRITICAL for switcher
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),

        // Animated Step Content
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (child, animation) {
            final slideIn =
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                );

            final slideOut = Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

            if (child.key == ValueKey(state.currentStep)) {
              return SlideTransition(
                position: slideIn,
                child: FadeTransition(opacity: animation, child: child),
              );
            } else {
              return SlideTransition(
                position: slideOut,
                child: FadeTransition(opacity: animation, child: child),
              );
            }
          },
          child: SizedBox(
            // The Key is essential for AnimatedSwitcher
            key: ValueKey(state.currentStep),
            child: stepContent, // Use the widget passed from the parent
          ),
        ),

        // Navigator Buttons
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: StepNavigator(
            currentStep: state.currentStep,
            totalSteps: 3,
            onNext: onNext,
            onBack: onBack,
            onRegister: onRegister,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}
