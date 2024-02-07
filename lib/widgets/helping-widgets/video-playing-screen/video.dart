import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video-playing/video_playing.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatelessWidget {
  const VideoItem(
      {super.key,
      required this.isPortrait,
      required this.controller,
      required this.isSeekLeft,
      required this.isSeekRight,
      required this.showControls,
      required this.isShowDuration,
      required this.seekDuration,
      required this.playAndPause});
  final bool isPortrait;
  final void Function() playAndPause;
  final VideoPlayerController controller;
  final bool showControls;
  final Function(bool value) seekDuration;
  final bool isSeekLeft;
  final bool isSeekRight;
  final bool isShowDuration;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onLongPressStart: (details) {
            if (details.localPosition.dx >
                MediaQuery.of(context).size.width / 2) {
              controller.setPlaybackSpeed(2);
            } else {
              controller.setPlaybackSpeed(0.25);
            }
          },
          onLongPressEnd: (details) {
            controller.setPlaybackSpeed(1);
          },
          onDoubleTapDown: (details) {
            if (details.localPosition.dx >
                MediaQuery.of(context).size.width / 2) {
              seekDuration(true);
            } else {
              seekDuration(false);
            }
          },
          onTap: () {
            playAndPause();
          },
          child: Stack(
            fit: isPortrait ? StackFit.loose : StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: InteractiveViewer(child: VideoPlayer(controller)),
              ),
              showControls
                  ? Icon(controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow)
                  : const SizedBox(),
              Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        controller.setPlaybackSpeed(2);
                      },
                      icon: const Icon(Icons.settings))),
              if (isSeekRight)
                Positioned(
                  // Adjust as per your requirement
                  right: 0,
                  // Distance from the right edge of the parent widget
                  child: Container(
                    width: 100, // Specify width
                    height: 200, // Specify height
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(100),
                          bottomStart: Radius.circular(100)),
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          VideoPlayingHelper.videoDuration(
                              controller.value.position),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Icon(Icons.fast_forward),
                      ],
                    ),
                  ),
                ),
              if (isShowDuration)
                ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, VideoPlayerValue value, child) {
                      return Text(
                        VideoPlayingHelper.videoDuration(value.position),
                        style: Theme.of(context).textTheme.labelLarge,
                      );
                    }),
              if (isSeekLeft)
                Positioned(
                  // Adjust as per your requirement
                  left: 0,
                  // Distance from the right edge of the parent widget
                  child: Container(
                    width: 100, // Specify width
                    height: 200, // Specify height
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(100),
                          bottomEnd: Radius.circular(100)),
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          VideoPlayingHelper.videoDuration(
                              controller.value.position),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Icon(Icons.fast_rewind),
                      ],
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
