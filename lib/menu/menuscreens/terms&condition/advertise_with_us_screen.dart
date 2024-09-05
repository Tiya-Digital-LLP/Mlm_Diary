// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/terms&condition/controller/terms_controller.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';

class AddwertiseWithUs extends StatefulWidget {
  const AddwertiseWithUs({super.key});

  @override
  State<AddwertiseWithUs> createState() => _AdwithusState();
}

class _AdwithusState extends State<AddwertiseWithUs>
    with SingleTickerProviderStateMixin {
  final TermsController _termsController = Get.put(TermsController());
  final TutorialVideoController videoController =
      Get.put(TutorialVideoController());
  static const String position = 'advertisewithus';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
    _termsController.fetchTermsAndConditions();
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
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.048,
            color: Colors.black,
            fontFamily: Assets.fontsSatoshiRegular,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Builder(
                  builder: (context) {
                    return Obx(() {
                      if (_termsController.isLoading.value) {
                        return CustomLottieAnimation(
                          child: Lottie.asset(Assets.lottieLottie),
                        );
                      } else if (_termsController.termsAndConditions.value !=
                          null) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            HtmlUnescape().convert(_termsController
                                .termsAndConditions.value
                                .toString()),
                          ),
                        );
                      } else {
                        return const Text(
                          'Failed to load terms and conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        );
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
