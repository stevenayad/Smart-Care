import 'package:flutter/material.dart';

Widget buildNavagationtitle(
  BuildContext context,
  String title,
  IconData icon, {
  Function()? onTap,
}) {
  return ListTile(
    onTap: onTap,
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade100,
      ),
      child: Icon(icon, color: Theme.of(context).primaryColor),
    ),
    title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
  );
}
