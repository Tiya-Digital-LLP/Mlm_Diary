import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  final String titleText;
  final VoidCallback? onTap;

  const CustomAppBar({
    super.key,
    required this.size,
    required this.titleText,
    this.onTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(size.height * 0.012),
        child: Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            customBorder: const CircleBorder(),
            child: SvgPicture.asset(Assets.svgBack),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        titleText,
        style: textStyleW700(
          size.width * 0.048,
          AppColors.blackText,
        ),
      ),
      actions: [
        SvgPicture.asset(
          Assets.svgPlay,
          height: size.width * 0.08,
          width: size.width * 0.08,
        ),
        const SizedBox(width: 18),
      ],
    );
  }
}
