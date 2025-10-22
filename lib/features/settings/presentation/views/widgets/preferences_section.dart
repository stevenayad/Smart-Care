import 'package:flutter/material.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/settings_title.dart';
import 'package:smartcare/features/settings/presentation/views/widgets/setting_section.dart';

class PreferencesSection extends StatefulWidget {
  const PreferencesSection({super.key});

  @override
  State<PreferencesSection> createState() => _PreferencesSectionState();
}

class _PreferencesSectionState extends State<PreferencesSection> {
  @override
  Widget build(BuildContext context) {
    String? selectedLanguage = 'English';
    List<String> items = ['Arbic', 'English'];
    return settingsection(context, 'Preferences', [
      settingTile(
        icon: Icons.notifications,
        title: 'Notifications',
        subtitle: 'Enable app notifications',
        trailing: Switch(value: false, onChanged: (value) {}),
      ),
      settingTile(
        icon: Icons.dark_mode,
        title: 'Dark Mode',
        subtitle: 'Use dark theme throughout the app',
        trailing: Switch(value: false, onChanged: (value) {}),
      ),
      settingTile(
        icon: Icons.language,
        title: 'Language',
        subtitle: 'Select your preferred language',
        trailing: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              ),
              alignment: Alignment.bottomCenter,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              items: items
                  .map(
                    (lang) => DropdownMenuItem(value: lang, child: Text(lang)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
          ),
        ),
      ),
    ]);
  }
}
