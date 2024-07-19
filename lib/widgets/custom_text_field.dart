import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/login/controller/login_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

class MobileEmailField extends StatefulWidget {
  final bool byDefault;
  const MobileEmailField({super.key, required this.byDefault});

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: controller.isEmailTyping.value
                ? isValid.value
                    ? Colors.green
                    : Colors.red
                : AppColors.containerBorder.withOpacity(0.4),
          ),
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
              'Enter Your Email / Mobile',
              style: textStyleW500(
                  size.width * 0.033, AppColors.blackText.withOpacity(0.5)),
            ),
            8.sbh,
            SizedBox(
              height: 12,
              child: TextField(
                cursorHeight: 20,
                cursorColor: AppColors.blackText,
                controller: controller.email.value,
                onChanged: (value) {
                  setState(() {
                    controller.isEmailTyping.value = true;
                    isValid.value = controller.validateInput(value);
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
