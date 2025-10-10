import 'dart:async';
import 'package:fixmec/pages/ui/home.dart';
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
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeFixMec()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenFixMec(),
    );
  }
}
