import "package:animated_splash_screen/animated_splash_screen.dart";
import "package:fixmec/pages/ui/home.dart";
import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

class SplashScreenFixMec extends StatelessWidget {
  const SplashScreenFixMec({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset("assets/animation/Happy Mechanic.json"),
      ),
      nextScreen: HomeFixMec(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3500,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      splashIconSize: 400,
    );
  }
}
