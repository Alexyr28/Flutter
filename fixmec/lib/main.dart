import 'package:flutter/material.dart';
import 'package:fixmec/pages/ui/splash_screen.dart';

void main() {
  runApp(const FixMec());
}

class FixMec extends StatefulWidget {
  const FixMec({super.key});

  @override
  State<FixMec> createState() => _FixMecState();
}

class _FixMecState extends State<FixMec> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenFixMec(),
    );
  }
}
