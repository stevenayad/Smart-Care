import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

PreferredSizeWidget customappbar(
  BuildContext context,
  String text, {
  void Function()? onPressed,
  List<Widget>? actions,
  bool isIcon = true,
}) {
  return AppBar(
    backgroundColor: AppColors.primaryblue,
    actions: actions,
    title: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    leading: isIcon
        ? IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          )
        : null,
  );
}
