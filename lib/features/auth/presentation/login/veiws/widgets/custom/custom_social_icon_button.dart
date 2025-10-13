import 'package:flutter/material.dart';

class CustumSocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CustumSocialIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1),
        ),
        child: Icon(icon),
      ),
    );
  }
}
