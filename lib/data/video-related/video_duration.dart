import 'package:svdomain/data/hive/video_metadata.dart';
import 'package:video_compress/video_compress.dart';

class VideoDuration {
  static Future<String> getTime(String path) async {
    if (VideoDurationDb.getAllPaths().contains(path)) {
      final double time = VideoDurationDb.getTime(path);
      return videoDuration(time);
    } else {
      final mediaInfo = await VideoCompress.getMediaInfo(path);
      await VideoDurationDb.addVideo(path, mediaInfo.duration!);
      return videoDuration(mediaInfo.duration!);
    }
  }

  static String videoDuration(double durationInMilliseconds) {
    int durationInMillisecondsInt = durationInMilliseconds.round();
    Duration duration = Duration(milliseconds: durationInMillisecondsInt);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
