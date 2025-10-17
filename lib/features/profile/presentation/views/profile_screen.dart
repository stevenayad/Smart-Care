import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Profilecubit(ProfileRepoimplemtation(api: DioConsumer(Dio())))
            ..fetchProfiledata(),
      child: Scaffold(body: ProfileBody()),
    );
  }
}
