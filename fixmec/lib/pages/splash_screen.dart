import 'dart:async';

import 'package:fixmec/pages/home_page.dart';
import 'package:flutter/material.dart';

class FixMecSplash extends StatefulWidget {
  const FixMecSplash({super.key});

  @override
  State<FixMecSplash> createState() => _FixMecSplashState();
}

class _FixMecSplashState extends State<FixMecSplash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FixMecHome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/icons/motorbikesplash.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
