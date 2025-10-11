import 'package:flutter/material.dart';

class HomeFixMec extends StatelessWidget {
  const HomeFixMec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/icons/repair.png", fit: BoxFit.contain),
        ),
        title: const Text(
          "FixMec",
          style: TextStyle(
            fontFamily: 'MiFuente',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(child: const Center(child: Text("Bienvenido a FixMec"))),
    );
  }
}
