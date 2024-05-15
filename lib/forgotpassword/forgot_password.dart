import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/forgotpassword/controller/forgot_password_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/border_text_field.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: AppColors.white),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomBackButton(),
              ),
              SizedBox(
                height: size.height * 0.20,
                width: size.height * 0.20,
                child: Image.asset(Assets.imagesLock),
              ),
              SizedBox(height: size.height * 0.035),
              Text(
                "Forgot password?",
                style: textStyleW700(size.width * 0.075, AppColors.blackText),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "Enter your email for verification process,\nwe will send 4 digits code to your email",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: textStyleW500(size.width * 0.040, AppColors.blackText),
              ),
              20.sbh,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderTextField(
                  controller: controller.email.value,
                  hint: " Enter Your Email/Mobile",
                  textInputType: const [],
                  keyboard: TextInputType.text,
                  byDefault: !controller.isEmailTyping.value,
                  maxLength: 25,
                ),
              ),
              30.sbh,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  title: "Submit",
                  btnColor: AppColors.primaryColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    Get.toNamed(Routes.otp);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
