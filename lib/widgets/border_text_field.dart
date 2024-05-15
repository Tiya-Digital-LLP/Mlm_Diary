import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class BorderTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isError;
  final bool readOnly;
  final bool byDefault;
  final int maxLength;
  final List<TextInputFormatter> textInputType;
  final TextInputType keyboard;
  final ValueChanged<String>? onChanged;
  final double height;

  const BorderTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.isError = false,
    this.readOnly = false,
    required this.textInputType,
    required this.keyboard,
    required this.byDefault,
    this.onChanged,
    required this.maxLength,
    this.height = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
            color: byDefault
                ? AppColors.containerBorder.withOpacity(0.4)
                : isError
                    ? AppColors.redText
                    : AppColors.greenBorder),
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Center(
          child: TextField(
            autocorrect: false,
            readOnly: readOnly,
            keyboardType: keyboard,
            inputFormatters: textInputType,
            onChanged: onChanged,
            maxLength: maxLength,
            controller: controller,
            style: textStyleW500(size.width * 0.04, AppColors.blackText),
            cursorColor: AppColors.blackText,
            decoration: InputDecoration(
              counterText: "",
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
