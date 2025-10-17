import 'package:flutter/material.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/bottom_widget.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_card_content.dart';
import 'package:smartcare/features/auth/presentation/register/views/widgets/register_cart_painter.dart';
import 'package:smartcare/features/auth/presentation/widgets/header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            children: [

              Header(),

              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  double cardWidth = constraints.maxWidth;
                  double cardHeight = 550.0;

                  return SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: CustomPaint(
                      painter: RegisterCardPainter(
                        AppThemes.lightTheme.primaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: RegisterCardContent(),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              BottomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
