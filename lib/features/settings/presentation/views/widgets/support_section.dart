import 'package:flutter/material.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/setting_section.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/settings_title.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return settingsection(context, 'Support', [
      settingTile(
        icon: Icons.help_center,
        title: 'Help & Support',
        subtitle: '',
        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      ),
    ]);
  }
}
