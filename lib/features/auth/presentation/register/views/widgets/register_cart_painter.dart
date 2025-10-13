import 'package:flutter/material.dart';

class RegisterCardPainter extends CustomPainter {
  final Color color;
  RegisterCardPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Radius for the top-left corner
    double topLeftRadius = 80.0;
    // Smaller radius for the bottom corners
    double bottomRadius = 30.0;

    // 1. Start at the top-left curve starting point (x=80, y=0)
    path.moveTo(topLeftRadius, 0);

    // --- 2. Custom Top-Right Sweep (Quadratic Bezier Curve) ---
    // This curve replaces the flat top line and the top-right arc.
    // P0 is implicitly (topLeftRadius, 0)
    // P1 (Control Point): Keeps the initial part of the curve flat near the top edge.
    final Offset controlPoint = Offset(size.width, 0);

    // P2 (End Point): The curve ends at the vertical center of the right side.
    final Offset endPoint = Offset(size.width, size.height / 2);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    // 3. Right side (straight): starts from center-right (size.height / 2)
    path.lineTo(size.width, size.height - bottomRadius);

    // 4. Bottom-right corner (quadratic bezier for smooth, small curve)
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - bottomRadius,
      size.height,
    );

    // 5. Bottom side (flat)
    path.lineTo(bottomRadius, size.height);

    // 6. Bottom-left corner (quadratic bezier for smooth, small curve)
    path.quadraticBezierTo(0, size.height, 0, size.height - bottomRadius);

    // 7. Left side (straight)
    path.lineTo(0, topLeftRadius);

    // 8. Top-left massive arc (closes the path)
    path.arcToPoint(
      Offset(topLeftRadius, 0),
      radius: Radius.circular(topLeftRadius),
      clockwise: true,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
