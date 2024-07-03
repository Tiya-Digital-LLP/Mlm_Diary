import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/video/controller/video_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _YourWidgetState();
}

class _YourWidgetState extends State<Video> {
  final ScrollController scrollercontroller = ScrollController();
  final VideoController controller = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    controller.fetchVideoList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MLM Videos',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.isLoading.value)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Center(
                  child: CustomLottieAnimation(
                    child: Lottie.asset(
                      Assets.lottieLottie,
                    ),
                  ),
                ),
              ),
            if (!controller.isLoading.value)
              ListView.builder(
                shrinkWrap: true,
                controller: scrollercontroller,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.videoList.length,
                itemBuilder: (context, index) {
                  final videoItem = controller.videoList[index];
                  final videoId = extractVideoId(videoItem.image ?? '');
                  // Decode the title with error handling
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
                            10.sbh,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    decodedTitle,
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:
                                          'assets/fonst/Metropolis-Black.otf',
                                    ).copyWith(fontSize: 15),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Check if videoItem.id is not null before calling togglevideoBookMark
                                    if (videoItem.id != null) {
                                      controller
                                          .togglevideoBookMark(videoItem.id!);
                                      setState(() {
                                        videoItem.isBookmark =
                                            !videoItem.isBookmark!;
                                      });
                                    } else {
                                      // Handle the case where videoItem.id is null
                                      if (kDebugMode) {
                                        print('Video ID is null');
                                      }
                                    }
                                  },
                                  child: Icon(
                                    videoItem.isBookmark ?? false
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    size: 28,
                                    color: videoItem.isBookmark ?? false
                                        ? Colors.red
                                        : Colors.grey,
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

// Helper method to decode titles safely
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
