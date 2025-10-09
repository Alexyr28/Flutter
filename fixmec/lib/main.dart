//import 'package:fixmec/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fixmec/pages/home_page.dart';

void main() {
  runApp(const FixMec());
}

class FixMec extends StatelessWidget {
  const FixMec({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FixMecHome());
  }
}
