import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:mlmdiary/login/controller/login_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/common_header.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_text_field.dart';
import 'package:mlmdiary/widgets/normal_button.dart';
import 'package:mlmdiary/widgets/password_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(Assets.imagesBg),
                ),
                Column(
                  children: [
                    CommonHeader(
                      onBackTap: () {},
                    ),
                    SizedBox(
                      height: size.height * 0.055,
                    ),
                    Text(
                      "Log in",
                      style: textStyleW700(
                        size.width * 0.07,
                        AppColors.blackText,
                      ),
                    ),
                    5.sbh,
                    Text(
                      "Log in into your account",
                      style:
                          textStyleW500(size.width * 0.05, AppColors.blackText),
                    ),
                    25.sbh,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                      ),
                      child: MobileEmailField(
                        byDefault: controller.isMobileTyping.value,
                        hint: 'Enter Your Email / Mobile',
                      ),
                    ),
                    15.sbh,
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: PasswordTextField(
                          controller: controller.password.value,
                          title: "Enter Your Password",
                          isError: controller.passwordError.value,
                          byDefault: !controller.isPasswordTyping.value,
                          onChanged: () {
                            controller.isPasswordTyping.value = true;
                            controller.passwordValidation();
                          },
                          hint: 'Enter Your Password',
                        ),
                      ),
                    ),
                    15.sbh,
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.forgotPassword);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: textStyleW500(
                            size.width * 0.036, AppColors.redText),
                      ),
                    ),
                    20.sbh,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: NormalButton(
                        onPressed: () {
                          controller.loginValidation(
                              context, controller.email.value.text);
                        },
                        text: 'Log in',
                        isLoading: controller.isLoading,
                      ),
                    ),
                    Expanded(child: Container()),
                    if (Platform.isIOS)
                      InkWell(
                        onTap: () async {
                          Get.offAllNamed(Routes.mainscreen);
                        },
                        child: Text(
                          'Skip',
                          style: textStyleW500(
                              size.width * 0.036, AppColors.primaryColor),
                        ),
                      ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have account?",
                          style: textStyleW500(
                              size.width * 0.036, AppColors.blackText),
                        ),
                        5.sbw,
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.signUp);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.redText,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "Create Account",
                              style: textStyleW500(
                                size.width * 0.035,
                                AppColors.redText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 10,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
