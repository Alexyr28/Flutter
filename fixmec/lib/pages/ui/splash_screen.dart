import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:fixmec/pages/ui/home.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class SplashScreenFixMec extends StatelessWidget {
  const SplashScreenFixMec({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "FixMec",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'MiFuente',
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset(
              "assets/animation/Happy Mechanic.json",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            AutoSizeText(
              textAlign: TextAlign.center,
              "Diagnóstico inteligente para tu moto",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "MiFuente",
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      nextScreen: HomeFixMec(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3500,
      backgroundColor: Color.fromARGB(255, 109, 217, 231),
      splashIconSize: double.maxFinite,
    );
  }
}
