import 'package:flutter/material.dart';

class DiagnosisFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const DiagnosisFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 2,
  });

  @override
  State<DiagnosisFixMec> createState() => _DiagnosisFixMec();
}

class _DiagnosisFixMec extends State<DiagnosisFixMec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
