import 'package:hive/hive.dart';

part 'liked_video.g.dart';

@HiveType(typeId: 2)
class LikedVideo extends HiveObject {
  @HiveField(0)
  final String videoFile;

  @HiveField(1)
  final DateTime favoriteTime;

  // (Optional) Add any additional fields you need, like:
  // - String name or title of the video
  // - bool isPlaying for keeping track of current playback
  // - int watchCount for analytics

  LikedVideo({
    required this.videoFile,
    required this.favoriteTime,
  });
}
