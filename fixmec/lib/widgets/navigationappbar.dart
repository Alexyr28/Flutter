import 'package:auto_size_text/auto_size_text.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomNavAppBar extends StatefulWidget {
  final int currentIndex;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<int> onIndexChanged;

  const CustomNavAppBar({
    super.key,
    required this.currentIndex,
    required this.isDark,
    required this.onThemeChanged,
    required this.onIndexChanged,
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
        title: AutoSizeText(
          loca.translate("start"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          minFontSize: 8,
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.chat_outlined),
        title: AutoSizeText(
          loca.translate("chat"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          minFontSize: 8,
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.query_stats_outlined),
        title: AutoSizeText(
          loca.translate("diagnost"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          minFontSize: 8,
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.warning_amber_outlined),
        title: AutoSizeText(
          loca.translate("fault"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          minFontSize: 8,
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
      SalomonBottomBarItem(
        icon: Icon(Icons.history),
        title: AutoSizeText(
          loca.translate("history"),
          style: const TextStyle(
            fontFamily: "MiFuente",
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          minFontSize: 8,
        ),
        selectedColor: const Color(0xFF00B4DB),
      ),
    ];
    return SalomonBottomBar(
      itemPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          widget.onIndexChanged(index);
        });
      },
      items: items,
    );
  }
}
