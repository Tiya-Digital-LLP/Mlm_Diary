import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart'; // assuming you're using Get for navigation

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: SvgPicture.asset(Assets.svgBack),
      ),
    );
  }
}
