import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
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
    this.gradientColors,
    this.textColor,
    this.elevation = 4.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> colors =
        gradientColors ??
        [
          AppColors.primaryblue.withValues(alpha: 0.9),
          AppColors.primaryLightColor.withValues(alpha: 0.9),
        ];

    final Color txtColor = textColor ?? AppColors.white;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: elevation,
        shadowColor: Colors.black26,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Padding(
              padding: padding!,
              child: icon == null
                  ? Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: txtColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
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
                          style: TextStyle(
                            color: txtColor,
                            fontSize: fontSize,
                            fontWeight: fontWeight,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: const Offset(1, 1),
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
      ),
    );
  }
}
