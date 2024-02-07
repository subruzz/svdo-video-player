import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video-playing/video_playing.dart';

class VideoControlls extends StatelessWidget {
  const VideoControlls(
      {super.key,
      required this.controller,
      required this.isMuted,
      required this.isPortrait,
      required this.muteVideo,
      required this.playAndPause,
      required this.playNextVideo,
      required this.singleVideo,
      required this.seekDuration,
      required this.playPrevious});
  final String? singleVideo;
  final void Function() muteVideo;
  final bool isMuted;
  final void Function() playNextVideo;
  final void Function() playAndPause;
  final VideoPlayerController controller;
  final void Function() playPrevious;
  final bool isPortrait;
  final Function(bool value) seekDuration;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            muteVideo();
          },
          icon: isMuted
              ? const Icon(Icons.volume_off)
              : const Icon(Icons.volume_up),
        ),
        if (singleVideo == null)
          IconButton(
            onPressed: () {
              playNextVideo();
            },
            icon: const Icon(Icons.skip_previous),
          ),
        IconButton(
            onPressed: () {
              seekDuration(false);
            },
            icon: const Icon(Icons.replay_10_rounded)),
        IconButton(
            onPressed: () {
              playAndPause();
            },
            icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow)),
        IconButton(
            onPressed: () {
              seekDuration(true);
            },
            icon: const Icon(Icons.forward_10_rounded)),
        if (singleVideo == null)
          IconButton(
            onPressed: () {
              playPrevious();
            },
            icon: const Icon(Icons.skip_next),
          ),
        IconButton(
            onPressed: () async {
              VideoPlayingHelper.toggleScreenMode(isPortrait);
            },
            icon: Icon(isPortrait
                ? Icons.screen_rotation
                : Icons.crop_portrait_rounded))
      ],
    );
  }
}
