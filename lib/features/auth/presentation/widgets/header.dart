import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
                Icons.whatshot, 
                size: 70,
              ),
              const SizedBox(height: 5),
              Text(
                'Smart care',
                  style: Theme.of(context).textTheme.headlineLarge,
                
              ),
      ],
    );
  }
}