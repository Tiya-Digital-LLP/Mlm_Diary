import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_three_dot_animation.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color btnColor;
  final Color titleColor;
  final Function onTap;
  final RxBool isLoading;

  const CustomButton({
    super.key,
    required this.title,
    required this.btnColor,
    required this.titleColor,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (!isLoading.value) {
          onTap();
        }
      },
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Obx(() {
          return isLoading.value
              ? CustomThreeDotAnimation(
                  child: Lottie.asset(
                  Assets.lottieDotLottie,
                ))
              : Text(
                  title,
                  style: textStyleW600(
                    size.width * 0.044,
                    titleColor,
                  ).copyWith(
                    fontFamily: Assets.fontsSatoshiRegular,
                  ),
                );
        }),
      ),
    );
  }
}
