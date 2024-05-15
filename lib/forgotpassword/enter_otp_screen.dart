import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_button.dart';

class EnterOTPScreen extends StatefulWidget {
  const EnterOTPScreen({super.key});

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CustomBackButton()],
            ),
            SizedBox(
              height: size.height * 0.16,
              width: size.height * 0.16,
              child: Image.asset(Assets.imagesMessage),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "OTP Verification",
              style: textStyleW700(size.width * 0.075, AppColors.blackText),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Enter OTP Sent To +88 7475775843\nand Dinesh@yahoo.com",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: textStyleW500(size.width * 0.044, AppColors.blackText),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            OtpTextField(
              onSubmit: (String verificationCode) {},
              numberOfFields: 4,
              fieldWidth: size.width * 0.15,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              cursorColor: AppColors.blackText,
              borderRadius: BorderRadius.circular(20),
              borderColor: AppColors.otpBorder,
              focusedBorderColor: AppColors.primaryColor,
              showFieldAsBox: true,
              textStyle: TextStyle(
                  fontSize: size.width * 0.042, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Did’t Received the OTP?",
                  style: textStyleW400(size.width * 0.042, AppColors.blackText),
                ),
                const Text("  "),
                Text(
                  "Resend",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: size.width * 0.042,
                    fontWeight: FontWeight.w500,
                    color: AppColors.redText,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomButton(
              title: "Verify",
              btnColor: AppColors.primaryColor,
              titleColor: AppColors.white,
              onTap: () {
                Get.toNamed(Routes.resetPassword);
              },
            ),
          ],
        ),
      ),
    );
  }
}
