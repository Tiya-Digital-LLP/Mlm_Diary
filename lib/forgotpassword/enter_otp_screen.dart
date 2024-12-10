import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/custom_button.dart';

class EnterOTPScreen extends StatefulWidget {
  const EnterOTPScreen({
    super.key,
  });

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  late int otp;
  late int userId;
  String enteredOtp = '';

  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    // Retrieve arguments
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      otp = args['otp'];
      userId = args['userId'];
    } else {
      // Handle if arguments are not available
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (kDebugMode) {
      print('userId: $userId, otp: $otp');
    }

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
            OtpTextField(
              numberOfFields: 6,
              onSubmit: (String verificationCode) {
                // Verify OTP
                if (verificationCode == otp.toString()) {
                  showToastverifedborder(
                      'OTP is Verified Please Set Password', context);
                  Get.offNamed(Routes.resetPassword,
                      arguments: {'userId': userId});
                } else {
                  showToasterrorborder('OTP is Incrorrect', context);
                }
              },
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                title: "Verify",
                btnColor: AppColors.primaryColor,
                titleColor: AppColors.white,
                onTap: () {
                  // Perform OTP validation
                  if (enteredOtp.length != 6) {
                    // Show error message for invalid OTP length
                    showToasterrorborder('OTP is Incrorrect', context);
                  } else if (enteredOtp != otp.toString()) {
                    // Show error message for incorrect OTP
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Invalid OTP. Please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showToastverifedborder(
                        'OTP is Verified Please Set Password', context);
                    Get.offNamed(Routes.resetPassword,
                        arguments: {'userId': userId});
                  }
                },
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
