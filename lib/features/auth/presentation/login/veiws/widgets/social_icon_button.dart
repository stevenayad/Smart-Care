import 'package:flutter/material.dart';
import 'package:smartcare/features/auth/presentation/login/veiws/widgets/custom/custom_social_icon_button.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustumSocialIconButton(icon: Icons.g_mobiledata_rounded, onTap: () {}),
        SizedBox(width: 20),
        CustumSocialIconButton(icon: Icons.facebook, onTap: () {}),
        SizedBox(width: 20),
        CustumSocialIconButton(icon: Icons.ac_unit, onTap: () {}),
      ],
    );
  }
}
