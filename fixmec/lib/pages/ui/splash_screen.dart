import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:fixmec/pages/ui/home.dart";
import "package:fixmec/services/localization_service.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:provider/provider.dart";

class SplashScreenFixMec extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const SplashScreenFixMec({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splashIconSize: size.height,
      backgroundColor: Colors.transparent,
      splash: Container(
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animation/Happy Mechanic.json",
                    height: size.height * 0.34,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    Provider.of<LocalizationService>(
                      context,
                    ).translate("app_name"),
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'MiFuente',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // texto más negro
                      letterSpacing: 1.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: AutoSizeText(
                      Provider.of<LocalizationService>(
                        context,
                      ).translate("diagnosis"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "MiFuente",
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 0.2,
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
      duration: 3000,
      nextScreen: HomeFixMec(isDark: isDark, onThemeChanged: onThemeChanged),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
