import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';

import '../../../generated/assets.dart';

class SignupDialog extends StatelessWidget {
  const SignupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Image.asset(
                Assets.imagesLogoutCheck,
                height: 50,
              ),
            ),
          ),
          16.sbh,
          Column(
            children: [
              Text(
                'Please Sign Up First',
                style: textStyleW700(
                  size.width * 0.040,
                  AppColors.blackText,
                ),
              ),
              5.sbh,
              Center(
                child: Text(
                  'If you need any adjustments or additional details, feel free to let me know!',
                  style: textStyleW400(
                    size.width * 0.035,
                    AppColors.blackText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: textStyleW700(
                            size.width * 0.035,
                            AppColors.blackText,
                          ),
                        ),
                      ),
                    ),
                    5.sbw,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shadowColor: AppColors.primaryColor,
                          elevation: 3,
                        ),
                        onPressed: () async {
                          Get.offAllNamed(Routes.login);
                        },
                        child: Text(
                          'SignUp',
                          style: textStyleW700(
                            size.width * 0.035,
                            AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
