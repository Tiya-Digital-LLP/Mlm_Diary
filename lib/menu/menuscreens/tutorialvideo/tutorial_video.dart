import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/tutorialvideo/controller/tutorial_video_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custon_test_app_bar.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TutorialVideo extends StatefulWidget {
  const TutorialVideo({super.key});

  @override
  State<TutorialVideo> createState() => _TutorialVideoState();
}

class _TutorialVideoState extends State<TutorialVideo> {
  final TutorialVideoController controller = Get.put(TutorialVideoController());
  String position = '';
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (kDebugMode) {
      print('Arguments: $args');
    }
    if (args != null && args['position'] != null) {
      position = args['position'];
      controller.fetchVideo(position, context);
    } else {
      controller.fetchVideo('', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustonTestAppBar(
        size: size,
        titleText: 'MLM Videos',
        videoController: controller,
        position: position,
        homeScreenController: homeScreenController,
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.isLoading.value)
              Center(
                child: CustomLottieAnimation(
                  child: Lottie.asset(
                    Assets.lottieLottie,
                  ),
                ),
              ),
            if (!controller.isLoading.value)
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.videoList.length,
                itemBuilder: (context, index) {
                  final videoItem = controller.videoList[index];
                  final videoId = extractVideoId(videoItem.video ?? '');
                  final decodedTitle = decodeTitle(videoItem.title);
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13.05)),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(13.05),
                        child: Column(
                          children: [
                            YoutubeViewer(videoId),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    decodedTitle,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:
                                          'assets/fonts/Metropolis-Black.otf',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  String decodeTitle(String? title) {
    if (title == null) return '';
    try {
      return utf8.decode(title.runes.toList());
    } catch (e) {
      return title;
    }
  }

  String extractVideoId(String url) {
    final regExp = RegExp(
      r'^https?:\/\/(?:www\.)?youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)?([a-zA-Z0-9_-]{11})',
    );
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }
}

class YoutubeViewer extends StatefulWidget {
  final String videoID;

  const YoutubeViewer(this.videoID, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YoutubeViewerState createState() => _YoutubeViewerState();
}

class _YoutubeViewerState extends State<YoutubeViewer>
    with AutomaticKeepAliveClientMixin {
  late final YoutubePlayerController controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController.fromVideoId(
      params: const YoutubePlayerParams(
        enableCaption: false,
        showVideoAnnotations: false,
        playsInline: false,
        showFullscreenButton: true,
        pointerEvents: PointerEvents.auto,
        showControls: true,
      ),
      videoId: widget.videoID,
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final player = YoutubePlayer(
      controller: controller,
      key: ValueKey(widget.videoID),
    );

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(13.05),
      child: player,
    );
  }
}
