import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';

class EditProfileGenderSelection extends StatelessWidget {
  const EditProfileGenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Editprofilecubit, EditProfilestate>(
      buildWhen: (previous, current) => current is EditProfileGenderChanged,
      builder: (context, state) {
        final cubit = context.read<Editprofilecubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gender",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<int>(
              title: const Text("Not Prefer to Say"),
              value: 0,
              groupValue: cubit.gender,
              onChanged: (value) {
                if (value != null) cubit.setGender(value);
              },
            ),
            RadioListTile<int>(
              title: const Text("Male"),
              value: 1,
              groupValue: cubit.gender,
              onChanged: (value) {
                if (value != null) cubit.setGender(value);
              },
            ),
            RadioListTile<int>(
              title: const Text("Female"),
              value: 2,
              groupValue: cubit.gender,
              onChanged: (value) {
                if (value != null) cubit.setGender(value);
              },
            ),
          ],
        );
      },
    );
  }
}
