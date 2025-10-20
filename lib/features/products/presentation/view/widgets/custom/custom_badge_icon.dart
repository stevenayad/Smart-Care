import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CustomBadgeIcon extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? badgeColor;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onTap;

  const CustomBadgeIcon({
    super.key,
    required this.icon,
    required this.count,
    this.badgeColor,
    this.iconColor,
    this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: badges.Badge(
        showBadge: count > 0,
        badgeContent: Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: badgeColor ?? Colors.red,
          padding: const EdgeInsets.all(6),
          shape: badges.BadgeShape.circle,
        ),
        position: badges.BadgePosition.topEnd(top: -8, end: -8),
        child: Icon(
          icon,
          color: iconColor ?? Colors.black,
          size: iconSize ?? 28,
        ),
      ),
    );
  }
}
