import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class PasswordTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isError;
  final bool byDefault;
  final Function? onChanged;
  final String hint;

  const PasswordTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isError = false,
    this.onChanged,
    required this.byDefault,
    required this.hint,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final TextFieldController textFieldController =
      Get.put(TextFieldController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.byDefault
                // ignore: deprecated_member_use
                ? AppColors.containerBorder.withOpacity(0.4)
                : widget.isError
                    ? AppColors.redText
                    : AppColors.greenBorder,
          ),
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: AppColors.blackText.withOpacity(0.12),
              offset: const Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: SizedBox(
          height: 75,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  cursorHeight: 20,
                  cursorColor: AppColors.blackText,
                  controller: widget.controller,
                  onChanged: (value) {
                    if (widget.onChanged != null) {
                      widget.onChanged!();
                    }
                  },
                  obscureText: textFieldController.obscureText.value,
                  obscuringCharacter: "●",
                  style: textStyleW400(size.width * 0.038, AppColors.blackText),
                  decoration: InputDecoration(
                    counterText: "",
                    labelText: widget.hint,
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.only(top: 16, left: 8, right: 8),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    textFieldController.obscureText.value =
                        !textFieldController.obscureText.value;
                    log("${textFieldController.obscureText.value}");
                  },
                  icon: Icon(
                    textFieldController.obscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.blackText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldController extends GetxController {
  RxBool obscureText = true.obs;
}
