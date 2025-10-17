import 'package:flutter/material.dart';

class CustomLineWithText extends StatelessWidget {
  final String text;
  final Color lineColor;
  final double thickness;

  const CustomLineWithText({
    Key? key,
    required this.text,
    this.lineColor = Colors.grey,
    this.thickness = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: lineColor, thickness: thickness),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
            child: Divider(color: lineColor, thickness: thickness),
          ),
        ],
      ),
    );
  }
}
