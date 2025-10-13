import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/acation_section.dart';
import 'package:smartcare/features/profile/presentation/views/widget/last_section.dart';
import 'package:smartcare/features/profile/presentation/views/widget/logout_button.dart';
import 'package:smartcare/features/profile/presentation/views/widget/top_section.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopSection(),
          AcationSection(),
          Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) => print('pointer down on LastSection'),
            child: LastSection(),
          ),
          LogoutButton(),
        ],
      ),
    );
  }
}
