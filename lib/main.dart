import 'package:flutter/material.dart';
import 'package:smartcare/features/home/presentation/views/home_screen.dart';
import 'package:smartcare/features/profile/presentation/views/profile_screen.dart';

void main() {
  runApp(const SmartCare());
}

class SmartCare extends StatelessWidget {
  const SmartCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
