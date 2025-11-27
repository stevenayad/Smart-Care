import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Profilecubit(
            ProfileRepoimplemtation(api: DioConsumer(Dio())),
          )..fetchProfiledata(),
        ),
        BlocProvider(
          create: (context) => Editprofilecubit(
            ProfileRepoimplemtation(api: DioConsumer(Dio())),
          ),
        ),
      ],
      child: Scaffold(
         appBar: customappbar(
        context,
        'Edit Profile',
        onPressed: () => Navigator.pop(context),
      ),
        body: EditProfileBody(),
      
      ),
    );
  }
}
