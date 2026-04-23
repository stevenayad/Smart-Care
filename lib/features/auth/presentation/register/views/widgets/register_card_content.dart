import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/logic_register_cubit/logic_register_cubit.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/build_current_step.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_form_layout.dart';
class RegisterCardContent extends StatelessWidget {
  const RegisterCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<RegisterCubit>().clearErrorMessage();
        }
      },
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        return RegisterFormLayout(
          state: state,
          stepContent: buildCurrentStep(state.currentStep, cubit, state),
        );
      },
    );
  }
}
