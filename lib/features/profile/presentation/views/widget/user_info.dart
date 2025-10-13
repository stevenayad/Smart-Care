import 'package:flutter/material.dart';
import 'package:smartcare/features/profile/presentation/views/widget/image_user.dart';
import 'package:smartcare/features/profile/presentation/views/widget/user_data.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: ImageUser(),
        ),
        const SizedBox(width: 16),
        UserData(),
      ],
    );
  }
}
