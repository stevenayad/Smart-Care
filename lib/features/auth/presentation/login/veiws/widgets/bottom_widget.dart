import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/register/views/register_page.dart';
import 'package:smartcare/features/auth/presentation/widgets/custom_bottom_widget.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomWidget(
                message: "Don't have an account?",
                actionText: "Sign Up",
                onActionTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
              );
  }
}