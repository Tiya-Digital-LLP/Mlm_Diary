import 'package:flutter/material.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color btnColor;
  final Color titleColor;
  final Function onTap;
  const CustomButton(
      {super.key,
      required this.title,
      required this.btnColor,
      required this.titleColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(title,
            style: textStyleW600(
              size.width * 0.044,
              titleColor,
            ).copyWith(
              fontFamily: Assets.fontsSatoshiRegular,
            )),
      ),
    );
  }
}
