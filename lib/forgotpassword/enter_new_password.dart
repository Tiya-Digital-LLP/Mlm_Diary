import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/forgotpassword/controller/forgot_password_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/password_border_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  const EnterNewPasswordScreen({super.key});

  @override
  State<EnterNewPasswordScreen> createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  int? userId;

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.white),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + size.height * 0.007,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomBackButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Center(
                      child: Text(
                        'Reset Password',
                        textAlign: TextAlign.center,
                        style: textStyleW700(
                          size.width * 0.05,
                          AppColors.blackText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Obx(
              () => PasswordBorderTextField(
                controller: controller.password.value,
                hint: "Your Password",
                textInputType: const [],
                keyboard: TextInputType.text,
                isError: controller.passwordError.value,
                byDefault: !controller.isPasswordTyping.value,
                onChanged: (value) {
                  controller.passwordValidation();
                  controller.isPasswordTyping.value = true;
                },
                maxLength: 18,
              ),
            ),
            15.sbh,
            Obx(
              () => PasswordBorderTextField(
                controller: controller.confirmPassword.value,
                hint: " Confirm Password",
                textInputType: const [],
                isError: controller.confirmPasswordError.value,
                keyboard: TextInputType.text,
                byDefault: !controller.isConfirmPasswordTyping.value,
                maxLength: 18,
                onChanged: (value) {
                  controller.confirmPasswordValidation();
                  controller.isConfirmPasswordTyping.value = true;
                },
              ),
            ),
            Expanded(
              child: Container(),
            ),
            CustomButton(
              title: "Save & Continue",
              btnColor: AppColors.primaryColor,
              titleColor: AppColors.white,
              onTap: () {
                // Check if passwords match
                if (controller.password.value.text !=
                    controller.confirmPassword.value.text) {
                  ToastUtils.showToast("Both Passwords Should be the Same.");
                } else {
                  // Call the method to send the change password request
                  controller.sendChangePasswordRequest(
                    context,
                    userId!,
                    controller.password.value.text,
                  );
                }
              },
            ),
            SizedBox(
              height:
                  MediaQuery.of(context).padding.bottom + size.height * 0.03,
            )
          ],
        ),
      ),
    );
  }
}
