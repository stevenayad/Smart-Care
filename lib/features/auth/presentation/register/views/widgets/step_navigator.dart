import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';

class StepNavigator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onRegister;
  final bool isLoading;

  const StepNavigator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
    required this.onBack,
    required this.onRegister,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 0)
          // TextButton(onPressed: onBack, child: const Text('Back')),
          CustomElevatedButton(
            onPressed: onBack,
            text: "Back",
            isFullWidth: false,
          ),

        if (currentStep == 0) const Spacer(),

        isLoading
            ? const CircularProgressIndicator()
            : CustomElevatedButton(
                isFullWidth: false,
                text: currentStep == totalSteps - 1 ? 'Register' : 'Next',
                onPressed: currentStep == totalSteps - 1 ? onRegister : onNext,
              ),
      ],
    );
  }
}
