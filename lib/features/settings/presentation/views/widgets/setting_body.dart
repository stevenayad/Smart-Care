import 'package:flutter/material.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/account_section.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/preferences_section.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/smart_care_fotter.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/support_section.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PreferencesSection(),
          AccountSection(),
          SupportSection(),
          SmartCareFooter(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
