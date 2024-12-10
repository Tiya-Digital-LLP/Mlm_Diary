import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';

String fontFamily = Assets.fontsSatoshiRegular;

TextStyle textStyleW700(double size, Color color) {
  return TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: size,
    color: color,
  );
}

TextStyle textStyleW600(double size, Color color) {
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color);
}

TextStyle textStyleW500(double size, Color color) {
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: color);
}

TextStyle textStyleW400(double size, Color color) {
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: color);
}

BoxShadow customBoxShadow() {
  return BoxShadow(
    color: AppColors.primaryColor.withOpacity(0.10),
    blurRadius: 13,
    offset: const Offset(0, 0),
    spreadRadius: 0,
  );
}
