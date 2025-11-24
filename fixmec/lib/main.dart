import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixmec/services/background_task.dart';
import 'package:fixmec/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixmec/pages/ui/splash_screen.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    log("🔥 Ejecutando WorkManager: $task");
    if (task == periodicTaskName) {
      await backgroundCheck(inputData ?? {});
      return Future.value(true);
    }
    return Future.value(false);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Workmanager
  Workmanager().initialize(callbackDispatcher);

  Workmanager().registerPeriodicTask(
    periodicTaskName,
    periodicTaskName,
    frequency: const Duration(hours: 17),
    initialDelay: const Duration(seconds: 10),
    constraints: Constraints(networkType: NetworkType.connected),
  );
  await NotificationService.initNotifications();
  await NotificationService.requestPermissions();

  final localizationService = LocalizationService.instance;
  await localizationService.loadSavedLanguage();

  runApp(
    ChangeNotifierProvider.value(
      value: localizationService,
      child: const FixMec(),
    ),
  );
}

class FixMec extends StatefulWidget {
  const FixMec({super.key});

  @override
  State<FixMec> createState() => _FixMecState();
}

class _FixMecState extends State<FixMec> {
  bool _isDark = false;
  bool _isloaded = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getBool('isDark') ?? false;
    setState(() {
      _isDark = savedTheme;
      _isloaded = true;
    });
  }

  void _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", value);
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationService>(context);
    if (!_isloaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: localization.locale,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreenFixMec(isDark: _isDark, onThemeChanged: _toggleTheme),
    );
  }
}
