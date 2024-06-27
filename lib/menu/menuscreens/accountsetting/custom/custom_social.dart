import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/accountsetting/controller/account_setting_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/normal_button.dart';

class CustomSocial extends StatefulWidget {
  const CustomSocial({super.key});

  @override
  State<CustomSocial> createState() => _CustomSocialState();
}

class _CustomSocialState extends State<CustomSocial> {
  final AccountSeetingController controller =
      Get.put(AccountSeetingController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
          backgroundColor: AppColors.background,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                children: [
                  buildSocialInput(
                    controller: controller.instat.value,
                    asset: Assets.svgInstagram,
                    hintText: "Copy & Paste Instagram URL",
                  ),
                  15.sbh,
                  buildSocialInput(
                    controller: controller.youtube.value,
                    asset: Assets.svgYoutube,
                    hintText: "Copy & Paste YouTube URL",
                  ),
                  15.sbh,
                  buildSocialInput(
                    controller: controller.facebook.value,
                    asset: Assets.svgLogosFacebook,
                    hintText: "Copy & Paste Facebook URL",
                  ),
                  15.sbh,
                  buildSocialInput(
                    controller: controller.linkdn.value,
                    asset: Assets.svgLogosLinkedinIcon,
                    hintText: "Copy & Paste LinkedIn URL",
                  ),
                  15.sbh,
                  buildSocialInput(
                    controller: controller.twitter.value,
                    asset: Assets.svgTwitter,
                    hintText: "Copy & Paste Twitter URL",
                  ),
                  15.sbh,
                  buildSocialInput(
                    controller: controller.telegram.value,
                    asset: Assets.svgTelegram,
                    hintText: "Copy & Paste Telegram URL",
                  ),
                  45.sbh,
                  NormalButton(
                      onPressed: () async {
                        if (kDebugMode) {
                          print('tap');
                        }
                        await controller.updateSocialMedia(context);
                      },
                      text: 'Save & Update'),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildSocialInput({
    required TextEditingController controller,
    required String asset,
    required String hintText,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.blackText),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            width: 50,
            child: SvgPicture.asset(asset),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 3.0),
            width: MediaQuery.of(context).size.width - 115,
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: AppColors.blackText,
              ),
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.background,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackText,
                ),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
