import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
                  showLiveFullscreenButton: false),
            ),
            showVideoProgressIndicator: true,
          )
        : const SizedBox.shrink(); // Handle the case where videoId is null
  }
}
