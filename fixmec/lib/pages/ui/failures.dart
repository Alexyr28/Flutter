import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/appbar.dart';
import 'package:fixmec/widgets/drawerheader.dart';
import 'package:fixmec/widgets/navigationappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FailuresFixMec extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const FailuresFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 3,
  });

  @override
  State<FailuresFixMec> createState() => _FailuresFixMec();
}

class _FailuresFixMec extends State<FailuresFixMec> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawerheader(
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
        currentIndex: _currentIndex,
      ),
      appBar: CustomAppBar(
        title: Provider.of<LocalizationService>(context).translate("fault2"),
      ),
      bottomNavigationBar: CustomNavAppBar(
        currentIndex: _currentIndex,
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
      ),
    );
  }
}
