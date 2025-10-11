import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:fixmec/pages/ui/home.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:page_transition/page_transition.dart";

class SplashScreenFixMec extends StatelessWidget {
  const SplashScreenFixMec({super.key});

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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                    "FixMec",
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'MiFuente',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // texto más negro
                      letterSpacing: 1.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: AutoSizeText(
                      "Diagnóstico inteligente para tu moto",
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
      nextScreen: HomeFixMec(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 3500,
    );
  }
}
