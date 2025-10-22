import 'package:flutter/material.dart';

Widget settingTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required Widget trailing,
}) {
  return ListTile(
    leading: Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.blue.shade600, size: 24),
    ),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: trailing,
  );
}
