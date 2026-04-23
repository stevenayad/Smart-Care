import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/logic_register_cubit/logic_register_cubit.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_elevated_button.dart';

class StepNavigator extends StatelessWidget {
  const StepNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        final currentStep = state.currentStep;
        final isLoading = state.isLoading;
        const totalSteps = 3;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentStep > 0)
              CustomElevatedButton(
                onPressed: cubit.onBackPressed,
                text: "Back",
                isFullWidth: false,
              ),

            if (currentStep == 0) const Spacer(),

            isLoading
                ? const CircularProgressIndicator()
                : CustomElevatedButton(
                    isFullWidth: false,
                    text: currentStep == totalSteps - 1 ? 'Register' : 'Next',
                    onPressed: currentStep == totalSteps - 1 ? cubit.onRegister : cubit.onNextPressed,
                  ),
          ],
        );
      },
    );
  }
}

