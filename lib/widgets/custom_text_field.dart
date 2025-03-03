import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/login/controller/login_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class MobileEmailField extends StatefulWidget {
  final bool byDefault;
  final String hint;

  const MobileEmailField(
      {super.key, required this.byDefault, required this.hint});

  @override
  // ignore: library_private_types_in_public_api
  _MobileEmailFieldState createState() => _MobileEmailFieldState();
}

class _MobileEmailFieldState extends State<MobileEmailField> {
  final LoginController controller = Get.put(LoginController());

  RxBool isValid = false.obs;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.isEmailTyping.value
                ? isValid.value
                    ? Colors.green
                    : Colors.red
                // ignore: deprecated_member_use
                : AppColors.containerBorder.withOpacity(0.4),
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
          height: 70,
          child: TextFormField(
            cursorHeight: 20,
            style: textStyleW700(size.width * 0.038, AppColors.blackText),
            cursorColor: AppColors.blackText,
            controller: controller.email.value,
            onChanged: (value) {
              setState(() {
                controller.isEmailTyping.value = true;
                isValid.value = controller.validateInput(value);
              });
            },
            decoration: InputDecoration(
              counterText: "",
              labelText: widget.hint,
              labelStyle:
                  textStyleW400(size.width * 0.038, AppColors.blackText),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            ),
          ),
        ),
      ),
    );
  }
}
