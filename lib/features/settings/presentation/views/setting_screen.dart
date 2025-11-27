import 'package:flutter/material.dart';
import 'package:smartcare/core/widget/custom_appbar.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/setting_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(
        context,
        'Settings',
        onPressed: () {
          Navigator.pop(context);
        },
        actions: null,
      ),
      body: SettingBody(),
    );
  }
}
