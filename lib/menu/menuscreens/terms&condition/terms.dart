// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/controller/terms_controller.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> with SingleTickerProviderStateMixin {
  final TermsController termsController = Get.put(TermsController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'advertisewithus';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
    termsController.fetchTermsAndConditions();
    videoController.fetchVideo(position, context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Terms & Condition',
          style: textStyleW700(
            size.width * 0.048,
            AppColors.blackText,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (position.isEmpty) {
                await videoController.fetchVideo('', context);
                Get.toNamed(Routes.tutorialvideo, arguments: {'position': ''});
              } else if (position == 'advertisewithus') {
                await videoController.fetchVideo('advertisewithus', context);
                Get.toNamed(Routes.tutorialvideo,
                    arguments: {'position': 'advertisewithus'});
              }
            },
            child: SvgPicture.asset(
              Assets.svgPlay,
              height: size.width * 0.08,
              width: size.width * 0.08,
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return Obx(() {
                    if (termsController.isLoading.value) {
                      return SizedBox(
                        height: size.height * 0.8,
                        width: size.width,
                        child: Center(
                          child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ),
                        ),
                      );
                    } else if (termsController.termsAndConditions.value !=
                        null) {
                      return Card(
                        color: Colors.white,
                        elevation: 9,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: HtmlWidget(
                              termsController.termsAndConditions.value.policy
                                  .toString(),
                              textStyle: textStyleW700(
                                size.width * 0.032,
                                AppColors.blackText,
                              ),
                            )),
                      );
                    } else {
                      return Text(
                        'Failed to load terms and conditions',
                        style: textStyleW400(
                          size.width * 0.032,
                          AppColors.blackText,
                        ),
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
