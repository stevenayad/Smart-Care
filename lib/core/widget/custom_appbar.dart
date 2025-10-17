import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

PreferredSizeWidget customappbar(
  context,
  String text,
  void Function()? onPressed,
  List<Widget>? actions,
) {
  return AppBar(
    backgroundColor: AppColors.primaryLightColor,
    actions: actions,
    title: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    leading: IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
    ),
  );
}
