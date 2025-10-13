import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isFullWidth;
  final IconData? icon;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.elevation = 3.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark ? AppColors.primaryblue : AppColors.primaryLightColor);

    final txtColor = textColor ?? AppColors.white;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: txtColor,
              elevation: elevation,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              shadowColor:
                  (isDark ? AppColors.darkMediumGrey : AppColors.mediumGrey)
                      .withValues(alpha: 0.4),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryDarkColor.withValues(alpha: 0.1);
                }
                if (states.contains(WidgetState.hovered)) {
                  return AppColors.primaryblue.withValues(alpha: 0.05);
                }
                return null;
              }),
            ),
        child: icon == null
            ? Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: txtColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: txtColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: txtColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
