import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    return videoId != null
        ? YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          showLiveFullscreenButton: false,
        ),
      ),
      showVideoProgressIndicator: true,
    )

        : const SizedBox.shrink();
  }
}

