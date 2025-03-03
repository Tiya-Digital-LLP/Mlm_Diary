import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final String label;

  const SocialButton({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            // ignore: deprecated_member_use
            color: AppColors.primaryColor.withOpacity(0.3),
            width: 1),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 20),
            10.sbw,
            Text(label,
                style: textStyleW700(
                  size.width * 0.035,
                  AppColors.primaryColor,
                  isMetropolis: true,
                )),
          ],
        ),
      ),
    );
  }
}
