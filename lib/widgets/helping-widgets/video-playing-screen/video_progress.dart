import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video-playing/video_playing.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoProgressBar extends StatelessWidget {
  const VideoProgressBar(
      {super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, VideoPlayerValue value, child) {
              return Text(
                   VideoPlayingHelper.videoDuration(value.position),
                style: Theme.of(context).textTheme.labelMedium,
              );
            }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                  backgroundColor: AppColors.fontnButton,
                  playedColor: AppColors.secondaryColor),
            ),
          ),
        ),
        Text(
          VideoPlayingHelper.videoDuration(controller.value.duration),
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}
