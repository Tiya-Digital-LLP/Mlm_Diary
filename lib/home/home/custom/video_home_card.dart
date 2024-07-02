import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mlmdiary/home/home/controller/homescreen_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoHomeCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String postTitle;
  final String postCaption;
  final String postVideo;
  final String dateTime;
  final int viewcounts;
  final HomeController controller;
  final int bookmarkId;
  final String url;
  final String type;

  const VideoHomeCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.postTitle,
    required this.postCaption,
    required this.postVideo,
    required this.dateTime,
    required this.viewcounts,
    required this.controller,
    required this.bookmarkId,
    required this.url,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: VideoPlayerWidget(url: postVideo),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Html(data: postTitle),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({super.key, required this.url});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    // Print the URL to the console
    if (kDebugMode) {
      print('Video URL: ${widget.url}');
    }

    controller = YoutubePlayerController.fromVideoId(
      params: const YoutubePlayerParams(
        enableCaption: false,
        showVideoAnnotations: false,
        playsInline: false,
        showFullscreenButton: true,
        pointerEvents: PointerEvents.auto,
        showControls: true,
      ),
      videoId: widget.url,
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: controller,
      key: ValueKey(widget.url),
    );

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(13.05),
      child: SizedBox(
        width: double.infinity, // Make the video player take the full width
        child: player,
      ),
    );
  }
}
