import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentFixMec extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  final double progress;
  final VoidCallback? onTap;

  const PercentFixMec({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.progress,
    this.onTap,
  });

  Color getProgressColor(double progress) {
    if (progress < 0.10) {
      return Colors.red;
    } else if (progress < 0.25) {
      return Colors.orange;
    } else if (progress < 0.60) {
      return Colors.green;
    } else {
      return Color(0xFF00B4DB);
    }
  }

  @override
  Widget build(BuildContext context) {
    //const Color primaryLightBlue = Color(0xFF00B4DB);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(2.0)),
            CircularPercentIndicator(
              radius: 27.0,
              lineWidth: 4,
              percent: progress.clamp(0, 1),
              center: Image.asset(
                image,
                color: getProgressColor(progress),
                width: 25,
                height: 25,
                fit: BoxFit.contain,
              ),
              progressColor: getProgressColor(progress),
              backgroundColor: Colors.grey.shade200,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 1200,
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: "MiFuente",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Flexible(
                    child: AnimatedTextKit(
                      key: UniqueKey(),
                      animatedTexts: [
                        TypewriterAnimatedText(
                          subtitle,
                          textStyle: TextStyle(
                            fontFamily: "MiFuente",
                            fontSize: 12,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
