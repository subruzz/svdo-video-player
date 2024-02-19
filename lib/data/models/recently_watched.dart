import 'package:hive/hive.dart';

part 'recently_watched.g.dart';

@HiveType(typeId: 3)
class RecentVideos extends HiveObject {
  @HiveField(0)
  final String videoFile;

  @HiveField(1)
  final DateTime recentTime;
  @HiveField(2)
  final double watchedLength;
  @HiveField(3)
  final double totalLength;

  // (Optional) Add any additional fields you need, like:
  // - String name or title of the video
  // - bool isPlaying for keeping track of current playback
  // - int watchCount for analytics

  RecentVideos(
      {required this.videoFile,
      required this.recentTime,
      required this.totalLength,
      required this.watchedLength,
      r});
}
