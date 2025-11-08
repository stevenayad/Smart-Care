import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/widgets/body_check_availability.dart';
import 'package:smartcare/features/check%20availability/widgets/custom_app_bar.dart';

class CheckAvailabilityScreen extends StatelessWidget {
  CheckAvailabilityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: customAppBar(),
      body: BodyCheckAvailablity(),
    );
  }
}
