import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isError;
  final bool byDefault;
  final Function? onChanged;

  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isError = false,
    this.onChanged,
    required this.byDefault,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.01),
      decoration: BoxDecoration(
        border: Border.all(
            color: byDefault
                ? AppColors.containerBorder.withOpacity(0.4)
                : isError
                    ? AppColors.redText
                    : AppColors.greenBorder),
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackText.withOpacity(0.12),
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyleW500(
                size.width * 0.033, AppColors.blackText.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 25,
            child: TextField(
              onChanged: (value) {
                onChanged!();
              },
              controller: controller,
              style: textStyleW500(size.width * 0.038, AppColors.blackText),
              cursorColor: AppColors.blackText,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
