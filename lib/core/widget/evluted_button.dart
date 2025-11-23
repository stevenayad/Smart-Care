import 'package:flutter/material.dart';

class EvlutedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double borderRadius;
  final List<Color> gradientColors;
  final Color shadowColor;

  const EvlutedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 55,
    this.borderRadius = 14,
    this.gradientColors = const [Color(0xFF5252FF), Color(0xFF8A80FF)],
    this.shadowColor = const Color(0xFFFF5252),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
