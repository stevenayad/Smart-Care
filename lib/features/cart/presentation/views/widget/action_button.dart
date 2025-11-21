import 'package:flutter/material.dart';

class ActionButtonCart extends StatelessWidget {
  const ActionButtonCart({super.key, required this.iconData, this.onPressed});
  final IconData iconData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: IconButton(
        icon: Icon(iconData, size: 18, color: Colors.black),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
