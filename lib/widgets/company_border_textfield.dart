import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class CompanyBorderTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isError;
  final bool readOnly;
  final bool byDefault;
  final List<TextInputFormatter> textInputType;
  final TextInputType keyboard;
  final ValueChanged<String>? onChanged;
  final double height;
  final VoidCallback? onTap;

  const CompanyBorderTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.isError = false,
    this.readOnly = false,
    required this.textInputType,
    required this.keyboard,
    required this.byDefault,
    this.onChanged,
    this.height = 80.0,
    this.onTap,
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
                // ignore: deprecated_member_use
                ? AppColors.containerBorder.withOpacity(0.4)
                : isError
                    ? AppColors.redText
                    : AppColors.greenBorder),
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            onTap: onTap,
            cursorHeight: 15,
            autocorrect: false,
            readOnly: readOnly,
            keyboardType: keyboard,
            inputFormatters: textInputType,
            onChanged: onChanged,
            controller: controller,
            textInputAction: TextInputAction.next,
            style: textStyleW700(size.width * 0.038, AppColors.blackText),
            cursorColor: AppColors.blackText,
            decoration: InputDecoration(
              counterText: "",
              labelText: hint,
              labelStyle:
                  textStyleW400(size.width * 0.038, AppColors.blackText),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 2,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
