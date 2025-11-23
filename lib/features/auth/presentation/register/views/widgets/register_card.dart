// FILE: features/auth/presentation/register/views/register_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/auth/presentation/Bloc/steps_bloc/steps_bloc.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_card_content.dart';

class register_card extends StatelessWidget {
  const register_card({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.transparent, // Make card transparent
      clipBehavior: Clip.antiAlias, // Clip the gradient
      child: Container(
        // This Container holds the gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.white, // Start with white
              AppColors.accentGreen, // Fade to light accent
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          // Move Padding inside the gradient Container
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: BlocProvider(
            create: (context) => StepsBloc(),
            child: RegisterCardContent(isLoading: isLoading),
          ),
        ),
      ),
    );
  }
}
