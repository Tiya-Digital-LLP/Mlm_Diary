import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';

class CustonTestAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  final String titleText;
  final VoidCallback? onTap;
  final TutorialVideoController? videoController;
  final HomeScreenController homeScreenController;
  final String position;

  const CustonTestAppBar({
    super.key,
    required this.size,
    required this.titleText,
    this.onTap,
    this.videoController,
    required this.position,
    required this.homeScreenController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(size.height * 0.012),
        child: Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () {
              homeScreenController.newIndex.value = 0;
              homeScreenController.tappedIndex.value = 0;
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
        titleText,
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
              await videoController?.fetchVideo('', context);
              Get.toNamed(Routes.tutorialvideo, arguments: {'position': ''});
            } else if (position == 'classified') {
              await videoController?.fetchVideo('classified', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'classified'});
            } else if (position == 'database') {
              await videoController?.fetchVideo('database', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'database'});
            } else if (position == 'advertisewithus') {
              await videoController?.fetchVideo('advertisewithus', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'advertisewithus'});
            } else if (position == 'news') {
              await videoController?.fetchVideo('news', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'news'});
            } else if (position == 'blog') {
              await videoController?.fetchVideo('blog', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'blog'});
            } else if (position == 'questionanswer') {
              await videoController?.fetchVideo('questionanswer', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'questionanswer'});
            } else if (position == 'company') {
              await videoController?.fetchVideo('company', context);
              Get.toNamed(Routes.tutorialvideo,
                  arguments: {'position': 'company'});
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
    );
  }
}
