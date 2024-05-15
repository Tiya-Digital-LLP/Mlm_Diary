import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/utils/app_colors.dart';

class PasswordBorderTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isError;
  final bool readOnly;
  final bool byDefault;
  final int maxLength;
  final List<TextInputFormatter> textInputType;
  final TextInputType keyboard;
  final Function(String)? onChanged;

  const PasswordBorderTextField({
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
  });

  @override
  State<PasswordBorderTextField> createState() =>
      _PasswordBorderTextFieldState();
}

class _PasswordBorderTextFieldState extends State<PasswordBorderTextField> {
  late final PasswordFieldController controller;

  @override
  void initState() {
    super.initState();
    controller = PasswordFieldController();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.005),
      decoration: BoxDecoration(
        border: Border.all(
            color: widget.byDefault
                ? AppColors.containerBorder.withOpacity(0.4)
                : widget.isError
                    ? AppColors.redText
                    : AppColors.greenBorder),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                // Ensure onChanged callback is provided and not null
                widget.onChanged?.call(value);
              },
              readOnly: widget.readOnly,
              keyboardType: widget.keyboard,
              inputFormatters: widget.textInputType,
              maxLength: widget.maxLength,
              controller: widget.controller,
              obscureText: controller.obscureText.value,
              obscuringCharacter: "●",
              style:
                  TextStyle(fontSize: size.width * 0.04, color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                counterText: "",
                hintText: widget.hint,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.obscureText.value = !controller.obscureText.value;
              log("${controller.obscureText.value}");
            },
            child: Obx(
              () => Icon(
                controller.obscureText.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: controller.obscureText.value
                    ? AppColors.blackText
                    : AppColors.blackText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordFieldController extends GetxController {
  RxBool obscureText = true.obs;
}
