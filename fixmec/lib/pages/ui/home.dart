import 'package:flutter/material.dart';

class HomeFixMec extends StatelessWidget {
  const HomeFixMec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home FixMec")),
      body: SafeArea(child: const Center(child: Text("Bienvenido a FixMec"))),
    );
  }
}
