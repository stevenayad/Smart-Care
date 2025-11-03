import 'package:flutter/material.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownWithOffsetState();
}

class _LanguageDropdownWithOffsetState extends State<LanguageDropdown> {
  String selectedLanguage = 'English';
  final List<String> items = ['English', 'Arbic'];

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: items
          .map(
            (lang) => MenuItemButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = lang;
                });
              },
              child: Text(lang),
            ),
          )
          .toList(),
      alignmentOffset: const Offset(0, 8),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
            return DropdownButtonHideUnderline(
              child: InkWell(
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedLanguage,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          },
    );
  }
}
