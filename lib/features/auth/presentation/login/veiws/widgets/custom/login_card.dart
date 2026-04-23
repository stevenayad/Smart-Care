import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/request_bloc/request_bloc.dart';
import 'package:smartcare/features/auth/presentation/Manager/logic_login_cubit/logic_login_cubit.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_card_content.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/login_card_painter.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authBloc: context.read<AuthBloc>()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth;
          double cardHeight = 380.0;

          return SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: CustomPaint(
              painter: LoginCardPainter(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                ),
                child: LoginCardContent(),
              ),
            ),
          );
        },
      ),
    );
  }
}
