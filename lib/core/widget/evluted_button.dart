import 'package:flutter/material.dart';
import 'package:smartcare/core/app_color.dart';

class EvalutedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;
  final List<Color>? gradientColors;
  final Color? shadowColor;

  const EvalutedButton({
    super.key,
    required this.text,
    this.onTap,
    this.height = 55,
    this.borderRadius = 14,
    this.gradientColors,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null;

    final List<Color> colors = isEnabled
        ? (gradientColors ??
            [
              AppColors.primaryblue.withValues(alpha: 0.9),
              AppColors.primaryLightColor.withValues(alpha: 0.9),
            ])
        : [Colors.grey, Colors.grey.shade400];

    final Color shadow = isEnabled
        ? (shadowColor ?? AppColors.primaryblue.withValues(alpha: 0.4))
        : Colors.transparent;

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: shadow,
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
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
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
