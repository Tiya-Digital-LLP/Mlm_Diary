import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class LinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double borderRadius;

  const LinedButton(
      {required this.onPressed,
      required this.text,
      this.fontSize = 16,
      this.height = 50,
      this.fontWeight = FontWeight.w600,
      this.borderRadius = 25,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              side: BorderSide(width: 2.0, color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius))),
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: AppColors.primaryColor),
          ),
        ));
  }
}
