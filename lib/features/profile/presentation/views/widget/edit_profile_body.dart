import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart'
    show Editprofilecubit;
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_action_buttons.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/edit_profile_image_picker.dart';
import 'package:smartcare/features/profile/presentation/views/widget/edit%20profile%20widgets/profile_form_fields.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileCubit = context.read<Editprofilecubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EditProfileImagePicker(),
            const SizedBox(height: 30),
            const ProfileFormFields(),
            const SizedBox(height: 30),
            EditProfileActionButtons(
              onSave: () => editProfileCubit.onSave(context),
              onCancel: () => editProfileCubit.onCancel(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
