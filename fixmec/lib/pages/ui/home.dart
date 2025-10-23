import 'package:fixmec/pages/ui/acerca_de.dart';
import 'package:fixmec/pages/ui/chtabot.dart';
import 'package:fixmec/pages/ui/diagnosis.dart';
import 'package:fixmec/pages/ui/failures.dart';
import 'package:fixmec/pages/ui/history.dart';
import 'package:fixmec/pages/ui/inicio.dart';
import 'package:fixmec/pages/ui/language.dart';
import 'package:fixmec/pages/ui/settings.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:fixmec/widgets/appbar.dart';
import 'package:fixmec/widgets/drawerheader.dart';
import 'package:fixmec/widgets/navigationappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final int currentIndex;

  const HomeFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
    this.currentIndex = 0,
  });

  @override
  State<HomeFixMec> createState() => _HomeFixMecState();
}

class _HomeFixMecState extends State<HomeFixMec> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    //Aqui Van los titulos para el appbar
    final List<String> titles = [
      loc.translate("app_name"),
      loc.translate("chatb"),
      loc.translate("diagnost"),
      loc.translate("fault2"),
      loc.translate("history"),
      loc.translate("configuration"),
      loc.translate("about"),
      loc.translate("language"),
    ];

    return Scaffold(
      endDrawer: CustomDrawerheader(
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
        currentIndex: _currentIndex,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      appBar: CustomAppBar(title: titles[_currentIndex]),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          InicioFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 0,
          ),
          ChatbotFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 1,
          ),
          DiagnosisFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 2,
          ),
          FailuresFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 3,
          ),
          HistoryFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 4,
          ),
          SettingsFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 5,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          AboutFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 6,
          ),
          LanguageFixMec(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
            currentIndex: 7,
          ),
        ],
      ),
      bottomNavigationBar: CustomNavAppBar(
        currentIndex: _currentIndex,
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
