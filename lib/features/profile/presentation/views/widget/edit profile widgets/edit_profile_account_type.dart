import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilecubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/editprofile/editprofilestate.dart';

class EditProfileAccountType extends StatelessWidget {
  const EditProfileAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Editprofilecubit, EditProfilestate>(
      buildWhen: (previous, current) =>
          current is EditProfileAccountTypeChanged,
      builder: (context, state) {
        final cubit = context.read<Editprofilecubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<int>(
              title: const Text("SelfUse"),
              value: 0,
              groupValue: cubit.accountType,
              onChanged: (value) {
                if (value != null) cubit.setAccountType(value);
              },
            ),
            RadioListTile<int>(
              title: const Text("FamilyUse"),
              value: 1,
              groupValue: cubit.accountType,
              onChanged: (value) {
                if (value != null) cubit.setAccountType(value);
              },
            ),
          ],
        );
      },
    );
  }
}
