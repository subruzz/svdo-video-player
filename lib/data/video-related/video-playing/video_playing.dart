import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/services.dart';

class VideoPlayingHelper {
  static Future setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

void seekDuration(bool value, VideoPlayerController controller) {
    Duration currentPosition = controller.value.position;
    int offset = value ? 10 : -10;
    controller.seekTo(Duration(seconds: currentPosition.inSeconds + offset));
  }

  static void toggleScreenMode(bool isPortrait) {
    if (isPortrait) {
      AutoOrientation.landscapeRightMode();
    } else {
      AutoOrientation.portraitAutoMode();
    }
  }

  static String videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
