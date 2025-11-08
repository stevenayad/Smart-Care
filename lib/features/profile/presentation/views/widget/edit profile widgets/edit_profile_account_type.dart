import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';

class EditProfileAccountType extends StatelessWidget {
  const EditProfileAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    final editprofilecubit = BlocProvider.of<Editprofilecubit>(context);
    return Column(
      children: [
        Text(
          "Account Type",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            RadioListTile<int>(
              title: const Text("SelfUse"),
              value: 0,
              groupValue: editprofilecubit.accountType,
              onChanged: (value) {
                editprofilecubit.accountType = value;
              },
            ),
            RadioListTile<int>(
              title: const Text("FamilyUse"),
              value: 1,
              groupValue: editprofilecubit.accountType,
              onChanged: (value) {
                editprofilecubit.accountType = value;
              },
            ),
          ],
        ),
      ],
    );
  }
}
