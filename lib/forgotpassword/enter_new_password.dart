import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/forgotpassword/controller/forgot_password_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_button.dart';
import 'package:mlmdiary/widgets/password_border_text_field.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  const EnterNewPasswordScreen({super.key});

  @override
  State<EnterNewPasswordScreen> createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  late int userId;

  @override
  void initState() {
    super.initState();
    // Retrieve userId from arguments
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null && args['userId'] != null) {
      userId = args['userId'];
    } else {
      // Handle if userId is not available in arguments
      userId = 0; // Set a default value or handle appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
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
            ),
            15.sbh,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => PasswordBorderTextField(
                  controller: controller.confirmPassword.value,
                  hint: "Confirm Password",
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
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                title: "Save & Continue",
                btnColor: AppColors.primaryColor,
                titleColor: AppColors.white,
                onTap: () {
                  // Check if passwords match
                  if (controller.password.value.text !=
                      controller.confirmPassword.value.text) {
                    showToasterrorborder(
                        "Both Passwords Should be the Same.", context);
                  } else {
                    // Call the method to send the change password request
                    controller.sendChangePasswordRequest(
                      context,
                      userId,
                      controller.password.value.text,
                    );
                  }
                },
                isLoading: controller.isLoading,
              ),
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
