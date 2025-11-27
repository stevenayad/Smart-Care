import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/check%20availability/domain/repositories/availability_repo_impl.dart';
import 'package:smartcare/features/check%20availability/presentation/bloc/availability_bloc.dart';
import 'package:smartcare/features/check%20availability/presentation/views/widgets/body_check_availability.dart';
import 'package:smartcare/features/check%20availability/presentation/views/widgets/custom_app_bar.dart';

class CheckAvailabilityScreen extends StatelessWidget {
  final String productId;
  CheckAvailabilityScreen({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final ApiConsumer apiConsumer = DioConsumer(dio);
    final repo = AvailabilityRepoImpl(api: apiConsumer);

    return BlocProvider(
      create: (context) =>
          AvailabilityBloc(repo)..add(CheckAvailabilityEvent(productId)),
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: customAppBar(),
        body: BodyCheckAvailablity(),
      ),
    );
  }
}
