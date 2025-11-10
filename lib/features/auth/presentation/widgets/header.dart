import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/image/smartcare_logo.png',
          height: 150,
          width: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
