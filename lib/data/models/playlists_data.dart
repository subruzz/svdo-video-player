import 'package:hive/hive.dart';

part 'playlists_data.g.dart';

@HiveType(typeId: 1)
class PlayListModels extends HiveObject {
  @HiveField(0)
  final String pName;
  @HiveField(1)
  List<String> pVideos = [];

  PlayListModels({required this.pName, required this.pVideos});
}
