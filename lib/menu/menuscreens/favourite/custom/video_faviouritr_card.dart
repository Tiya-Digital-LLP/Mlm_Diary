import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoFavouriteCard extends StatelessWidget {
  final String postTitle;
  final String postVideo;

  const VideoFavouriteCard({
    super.key,
    required this.postTitle,
    required this.postVideo,
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

    String? videoId = extractYoutubeVideoId(widget.url);
    if (videoId == null) {
      // Handle the case where the video ID could not be extracted
      if (kDebugMode) {
        print('Invalid video URL: ${widget.url}');
      }
      return;
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
      videoId: videoId,
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

  // Function to extract the YouTube video ID from the URL
  String? extractYoutubeVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    }

    return null;
  }
}
