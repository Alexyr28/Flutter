import 'package:fixmec/pages/ui/chtabot.dart';
import 'package:fixmec/pages/ui/diagnosis.dart';
import 'package:fixmec/pages/ui/failures.dart';
import 'package:fixmec/pages/ui/history.dart';
import 'package:fixmec/pages/ui/home.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomNavAppBar extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  const CustomNavAppBar({
    super.key,
    required this.currentIndex,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<CustomNavAppBar> createState() => _CustomNavAppBar();
}

class _CustomNavAppBar extends State<CustomNavAppBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loca = Provider.of<LocalizationService>(context);
    final items = [
      SalomonBottomBarItem(
        icon: Icon(Icons.home_rounded),
        title: Text(
          loca.translate("start"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.chat_outlined),
        title: Text(
          loca.translate("chat"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.query_stats_outlined),
        title: Text(
          loca.translate("diagnost"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.warning_amber_outlined),
        title: Text(
          loca.translate("fault"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.history),
        title: Text(
          loca.translate("history"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
    ];
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: (index) {
        Widget nextPage;
        switch (index) {
          case 0:
            nextPage = HomeFixMec(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
              currentIndex: 0,
            );
            break;
          case 1:
            nextPage = ChatbotFixMec(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
              currentIndex: 1,
            );
            break;
          case 2:
            nextPage = DiagnosisFixMec(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
              currentIndex: 2,
            );
            break;
          case 3:
            nextPage = FailuresFixMec(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
              currentIndex: 3,
            );
            break;
          case 4:
            nextPage = HistoryFixMec(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
              currentIndex: 4,
            );
            break;
          default:
            return;
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
          (route) => false,
        );
      },
      items: items,
    );
  }
}
