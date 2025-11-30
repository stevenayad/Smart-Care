import 'package:flutter/material.dart';
import 'dart:ui';

class LoginCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Base Path
    Path card = Path();

    double radiusTop = 90;
    double radiusBottom = 36;

    card.moveTo(radiusTop, 0);
    card.quadraticBezierTo(size.width, 0, size.width, size.height * 0.6);
    card.quadraticBezierTo(
      size.width,
      size.height,
      size.width * 0.6,
      size.height,
    );
    card.lineTo(size.width * 0.4, size.height);
    card.quadraticBezierTo(0, size.height, 0, size.height * 0.6);
    card.lineTo(0, radiusTop);
    card.arcToPoint(
      Offset(radiusTop, 0),
      radius: Radius.circular(radiusTop),
      clockwise: true,
    );

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // === 1) DEEP MULTI-GRADIENT BACKGROUND ===
    Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF005CFF), // Royal Blue
          Color(0xFF2E8BFF), // Azure
          Color(0xFF6BCBFF), // Aqua Bright
          Color(0xFFEFFBFF), // White Glow
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawPath(card, bg);

    // === 2) GLASS HIGHLIGHT ARC (Vision Pro Style) ===
    Paint glassArc = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.45),
          Colors.white.withValues(alpha: 0.05),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    Path highlightArc = Path();
    highlightArc.moveTo(0, size.height * 0.16);
    highlightArc.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.01,
      size.width,
      size.height * 0.18,
    );
    highlightArc.lineTo(size.width, size.height * 0.32);
    highlightArc.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.12,
      0,
      size.height * 0.27,
    );
    highlightArc.close();

    canvas.drawPath(highlightArc, glassArc);

    // === 3) HOLOGRAPHIC COLOR SHIFT LAYER ===
    Paint holo = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFF00E0FF), // Cyan pop
          Colors.transparent,
        ],
        radius: 1.2,
        center: Alignment.bottomRight,
      ).createShader(rect)
      ..blendMode = BlendMode.colorDodge;

    canvas.drawPath(card, holo);

    // === 4) NEON EDGE LIGHT BEAM ===
    Paint neon = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.8),
          Colors.blueAccent.withValues(alpha: 0.3),
          Colors.transparent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 30);

    canvas.drawPath(card, neon);

    // === 5) PREMIUM METALLIC STROKE ===
    Paint metallic = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.white, Color(0xFFBFE8FF), Colors.white],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    canvas.drawPath(card, metallic);

    // === 6) INNER SOFT GLOW ===
    Paint innerGlow = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withValues(alpha: 0.28), Colors.transparent],
        radius: 1,
        center: Alignment.topLeft,
      ).createShader(rect);

    canvas.drawPath(card, innerGlow);

    // === 7) REALISTIC DROP SHADOWS (dual-layer) ===
    canvas.drawShadow(card, Colors.black.withValues(alpha: 0.5), 35, true);
    canvas.drawShadow(
      card,
      Colors.blueAccent.withValues(alpha: 0.20),
      60,
      false,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
