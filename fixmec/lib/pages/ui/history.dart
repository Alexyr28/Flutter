import 'package:flutter/material.dart';

class HistoryFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const HistoryFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 4,
  });

  @override
  State<HistoryFixMec> createState() => _HistoryFixMec();
}

class _HistoryFixMec extends State<HistoryFixMec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
