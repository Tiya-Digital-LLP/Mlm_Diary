import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';

class NormalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final Icon? icon;
  final double borderRadius;
  final List<Color>? gradientColors;
  final RxBool isLoading;

  const NormalButton({
    required this.onPressed,
    required this.text,
    required this.isLoading,
    this.fontSize = 18,
    this.height = 60,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 30,
    this.gradientColors,
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Obx(() {
        return ElevatedButton(
          onPressed: isLoading.value ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              width: double.infinity,
              height: height,
              alignment: Alignment.center,
              child: isLoading.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : icon == null
                      ? Text(
                          text,
                          style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              color: Colors.white),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon!,
                            8.sbw,
                            Text(
                              text,
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  fontFamily: Assets.fontsSatoshiRegular,
                                  color: Colors.white),
                            ),
                          ],
                        ),
            ),
          ),
        );
      }),
    );
  }
}
