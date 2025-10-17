import 'package:flutter/material.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/bottom_widget.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/line_with_or.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/social_icon_button.dart';
import 'package:smartcare/features/auth/presentation/widgets/header.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_card_content.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_card_painter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  double cardHeight = 360.0;

                  return SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: CustomPaint(
                      painter: LoginCardPainter(
                        AppThemes.lightTheme.primaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: LoginCardContent(),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              LineWithOr(),

              const SizedBox(height: 20),

              SocialIconButton(),

              SizedBox(height: 20),

              BottomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
