import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ??
              () {
                Get.back();
              },
          customBorder: const CircleBorder(),
          child: Ink(child: SvgPicture.asset(Assets.svgBack)),
        ),
      ),
    );
  }
}
