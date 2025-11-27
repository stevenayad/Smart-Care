import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/profile/data/repo/profile_repoimplemtation.dart'
    show ProfileRepoimplemtation;
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/profile/profilecubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_action_buttons.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_image_picker.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/profile_form_fields.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              Profilecubit(ProfileRepoimplemtation(api: DioConsumer(Dio())))
                ..fetchProfiledata(),
        ),
        BlocProvider(
          create: (context) => Editprofilecubit(
            ProfileRepoimplemtation(api: DioConsumer(Dio())),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          final editprofilecubit = BlocProvider.of<Editprofilecubit>(context);
          return Scaffold(
            appBar: customappbar(
              context,
              'My Cart',
              onPressed: () {
                Navigator.pop(context);
              },
              actions: null,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: editprofilecubit.formKey,
                child: Column(
                  children: [
                    const EditProfileImagePicker(),
                    const SizedBox(height: 30),
                    ProfileFormFields(),
                    const SizedBox(height: 30),
                    EditProfileActionButtons(
                      onSave: () => editprofilecubit.onSave(context),
                      onCancel: () => editprofilecubit.onCancel(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
