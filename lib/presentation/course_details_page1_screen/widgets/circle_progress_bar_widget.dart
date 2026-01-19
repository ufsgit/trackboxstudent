import 'package:flutter/material.dart';

class CircularProgressWithIndicator extends StatelessWidget {
  final double progress; // Progress in percentage (0.0 to 1.0)
  final Color progressColor;
  final Color indicatorColor;
  final double indicatorSize;

  const CircularProgressWithIndicator({
    super.key,
    required this.progress,
    this.progressColor = Colors.blue,
    this.indicatorColor = Colors.red,
    this.indicatorSize = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final double progressValue = progress / 100;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 4,
            color: progressColor,
            backgroundColor: Colors.grey[300],
          ),
          Text(
            '65%',
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
