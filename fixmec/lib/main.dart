import 'package:flutter/material.dart';
import 'package:fixmec/pages/ui/splash_screen.dart';

void main() {
  runApp(const FixMec());
}

class FixMec extends StatelessWidget {
  const FixMec({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenFixMec(),
    );
  }
}
