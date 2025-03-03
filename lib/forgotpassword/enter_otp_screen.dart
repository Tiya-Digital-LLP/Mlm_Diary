import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/forgotpassword/controller/forgot_password_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/loader/custom_three_dot_animation.dart';
import 'package:pinput/pinput.dart';

class EnterOTPScreen extends StatefulWidget {
  final String email;
  final String phone;
  final String countrycode;
  final int otp;
  final int userId;

  const EnterOTPScreen({
    super.key,
    required this.otp,
    required this.userId,
    required this.email,
    required this.phone,
    required this.countrycode,
  });

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  final TextEditingController otpController = TextEditingController();
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.white),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + size.height * 0.007,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CustomBackButton()],
            ),
            SizedBox(
              height: size.height * 0.16,
              width: size.height * 0.16,
              child: Image.asset(Assets.imagesMessage),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "OTP Verification",
              style: textStyleW700(size.width * 0.075, AppColors.blackText),
            ),
            SizedBox(height: size.height * 0.02),
            Pinput(
              controller: otpController,
              length: 4,
              onChanged: (String verificationCode) {
                if (verificationCode.length == 4) {
                  _verifyOtp(verificationCode, context);
                } else {
                  // Handle other cases if needed
                }
              },
              onSubmitted: (String verificationCode) {
                if (verificationCode.length == 4) {
                  _verifyOtp(verificationCode, context);
                } else {
                  // Handle other cases if needed
                }
              },
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: textStyleW700(
                  size.width * 0.036,
                  AppColors.blackText,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: textStyleW700(
                  size.width * 0.036,
                  AppColors.primaryColor,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn’t Receive the OTP?",
                  style: textStyleW400(size.width * 0.042, AppColors.blackText),
                ),
                const Text("  "),
                Obx(
                  () => (controller.timerValue.value == 0)
                      ? GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();

                            controller.sendForgotPasswordRequest(
                              context,
                              getFormattedCountryCode(),
                            );
                            controller.timerValue.value = 30;
                            controller.startTimer();
                          },
                          child: Text(
                            "Resend",
                            style: textStyleW500(
                                size.width * 0.042, AppColors.primaryColor),
                          ),
                        )
                      : Text(
                          '${controller.timerValue.value} seconds',
                          style: textStyleW500(
                              size.width * 0.042, AppColors.blackText),
                        ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Obx(() {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _verifyOtp(otpController.text, context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.center,
                        child: controller.isLoading.value
                            ? CustomThreeDotAnimation(
                                child: Lottie.asset(Assets.lottieDotLottie),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  8.sbw,
                                  Text(
                                    'Verify',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: metropolisFontFamily,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ));
            })
          ],
        ),
      ),
    );
  }

  String getFormattedCountryCode() {
    // Removes the '+' sign from the country code
    return controller.selectedCountry.value?.callingCode.replaceAll('+', '') ??
        '';
  }

  void _verifyOtp(String verificationCode, BuildContext context) {
    if (verificationCode.length != 4) {
      showToasterrorborder('Please Enter OTP', context);
    } else {
      controller.verifyForgotPasswordRequest(context, widget.countrycode,
          otpController.value.text.toString(), widget.userId);
    }
  }
}
