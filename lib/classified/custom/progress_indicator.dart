import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double value;
  final String label;
  final Color backgroundColor;
  final Color progressColor;

  const CustomProgressIndicator({
    super.key,
    required this.value,
    required this.label,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
        5.sbh,
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
