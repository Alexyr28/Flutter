// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fixmec/pages/ui/home.dart';
import 'package:fixmec/pages/ui/login_page.dart';
import 'package:fixmec/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreenFixMec extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const SplashScreenFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<SplashScreenFixMec> createState() => _SplashScreenFixMecState();
}

class _SplashScreenFixMecState extends State<SplashScreenFixMec>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _initApp();
  }

  Future<void> _initApp() async {
    try {
      //inicialisar firebase toque de aqui hasta el otro comentario
      await Firebase.initializeApp();

      await Future.delayed(const Duration(seconds: 3));

      final user = FirebaseAuth.instance.currentUser;

      if (!mounted) return;

      _controller.forward();

      await Future.delayed(const Duration(milliseconds: 600));
      //vamos a verificar si hay un usuario logeado y segun eso va a home o login_page
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, _, _) => user == null
              ? LoginPage(
                  isDark: widget.isDark,
                  onThemeChanged: widget.onThemeChanged,
                )
              : HomeFixMec(
                  isDark: widget.isDark,
                  onThemeChanged: widget.onThemeChanged,
                ),
          transitionsBuilder: (_, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    } catch (e) {
      debugPrint("⚠️ Error en splash: $e");
      // Si hay algún error, redirige al login, de aqui pa abajo no toque nada mas
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginPage(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationService>(context);
    final size = MediaQuery.of(context).size;

    return FadeTransition(
      opacity: Tween(begin: 1.0, end: 0.0).animate(_controller),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [Color(0XFF004E92), Color(0XFF00B4DB)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animation/Happy Mechanic.json",
                    height: size.height * 0.34,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    localization.translate("app_name"),
                    style: const TextStyle(
                      fontSize: 50,
                      fontFamily: 'MiFuente',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: AutoSizeText(
                      localization.translate("diagnosis"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "MiFuente",
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        decoration: TextDecoration.none,
                      ),
                      minFontSize: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
