import 'package:flutter/material.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/setting_section.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/settings_title.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return settingsection(context, 'Account', [
      settingTile(
        icon: Icons.payment,
        title: 'Payment Method',
        subtitle: '',
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      ),
      settingTile(
        icon: Icons.privacy_tip,
        title: 'Privacy & Security',
        subtitle: '',
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      ),
    ]);
  }
}
