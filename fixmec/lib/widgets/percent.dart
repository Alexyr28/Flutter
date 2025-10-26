import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentFixMec extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  final double progress;

  const PercentFixMec({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryLightBlue = Color(0xFF00B4DB);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(2.0)),
          CircularPercentIndicator(
            radius: 27.0,
            lineWidth: 4,
            percent: progress,
            center: Image.asset(
              image,
              color: primaryLightBlue,
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
            progressColor: primaryLightBlue,
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
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
                AutoSizeText(
                  subtitle,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontFamily: "MiFuente", fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
