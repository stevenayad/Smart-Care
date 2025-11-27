import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Profilecubit(ProfileRepoimplemtation(api: DioConsumer(Dio()))),
      child: Scaffold(
        backgroundColor: const Color(0xffF6F8F6),
        body: ChangePasswordBody(),
      ),
    );
  }
}
