import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';

class EditProfileGenderSelection extends StatelessWidget {
  const EditProfileGenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final editprofilecubit = BlocProvider.of<Editprofilecubit>(context);
    return Column(
      children: [
        Text(
          "Gender",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            RadioListTile<int>(
              title: const Text("Not Prefer to Say"),
              value: 0,
              groupValue: editprofilecubit.gender,
              onChanged: (value) {
                editprofilecubit.gender = value;
              },
            ),
            RadioListTile<int>(
              title: const Text("Male"),
              value: 1,
              groupValue: editprofilecubit.gender,
              onChanged: (value) {
                editprofilecubit.gender = value;
              },
            ),
            RadioListTile<int>(
              title: const Text("Female"),
              value: 2,
              groupValue: editprofilecubit.gender,
              onChanged: (value) {
                editprofilecubit.gender = value;
              },
            ),
          ],
        ),
      ],
    );
  }
}
