
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/hive/liked_videos.dart';
import 'package:svdomain/data/models/liked_video.dart';

class LikedVideosProvider extends StateNotifier<List<LikedVideo>> {
  LikedVideosProvider() : super(LikedVideosDb.getLikedVideos());

  void _updateState() {
    state = LikedVideosDb.getLikedVideos();
  }

  bool addtToLiked(LikedVideo video) {
    final isLiked = LikedVideosDb.addtToLiked(video);
    _updateState();
    return isLiked;
  }

  void deleteFromLiked(var key) async {
    LikedVideosDb.deleteFromLiked(key);
    _updateState();
  }
}

final likedVideosProvider =
    StateNotifierProvider<LikedVideosProvider, List<LikedVideo>>(
        (ref) => LikedVideosProvider());
