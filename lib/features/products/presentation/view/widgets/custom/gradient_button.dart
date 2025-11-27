import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class SmallGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;
  final IconData? icon; // ✅ NEW
  final double iconSize; // ✅ NEW
  final Color iconColor; // ✅ NEW

  const SmallGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 45,
    this.borderRadius = 14,
    this.icon, // optional
    this.iconSize = 18,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      AppColors.primaryblue.withValues(alpha: 0.9),
      AppColors.primaryLightColor.withValues(alpha: 0.9),
    ];

    final shadow = AppColors.primaryblue.withValues(alpha: 0.4);

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadow,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: iconSize, color: iconColor),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
