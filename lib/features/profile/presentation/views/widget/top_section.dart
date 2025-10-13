import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/profile/presentation/views/widget/User_Info.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Container(
        decoration: BoxDecoration(color: AppColors.primaryLightColor),
        child: Column(
          children: [customappbar(context, 'My Profile', null), UserInfo()],
        ),
      ),
    );
  }
}
