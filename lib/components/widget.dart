import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentProgressBar extends StatelessWidget {
  final double textSize;
  final Color textColor;
  final Color progressColor;
  final Color backgroundColor;
  final double progress;

  const PercentProgressBar({
    super.key,
    this.textSize = 14.0,
    this.textColor = const Color(0xFF000000),
    this.progressColor = const Color(0xFF42A5F5),
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    double real = double.parse(progress.toStringAsFixed(2)) * 100;
    int percent = real.toInt();

    return LinearPercentIndicator(
      lineHeight: double.infinity,
      percent: progress,
      center: Text(
        '$percent%',
        style: TextStyle(
          fontSize: textSize,
          color: textColor,
        ),
      ),
      barRadius: const Radius.circular(16),
      progressColor: progressColor,
      backgroundColor: backgroundColor,
    );
  }
}
