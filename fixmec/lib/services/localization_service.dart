import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixmec/l10n/app_en.dart';
import 'package:fixmec/l10n/app_es.dart';

class LocalizationService extends ChangeNotifier {
  Locale _locale = const Locale('es');
  Map<String, String> _localizedStrings = es;

  Locale get locale => _locale;
  String translate(String key) => _localizedStrings[key] ?? key;

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language') ?? 'es';
    _setLanguage(savedLang);
  }

  void _setLanguage(String code) {
    _locale = Locale(code);
    _localizedStrings = code == 'en' ? en : es;
    notifyListeners();
  }

  Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', code);
    _setLanguage(code);
  }
}
