import 'dart:io';

import 'package:hive/hive.dart';
import 'package:svdomain/data/models/liked_video.dart';

class LikedVideosDb {
  static Box box = Hive.box('likedVideos');

  //to add to likevideos list
  static bool addtToLiked(LikedVideo video) {
    bool videoAlreadyExist = box.values
        .cast<LikedVideo>()
        .any((v) => v.videoFile == video.videoFile);
    if (videoAlreadyExist) {
      return true;
    } else {
      box.add(video);

      return false;
    }
  }

  //to delete from liked list
  static void deleteFromLiked(var key) async {
     await box.delete(key);
  }

  //to get all likedvideos
  static List<LikedVideo> getLikedVideos() {
    Box box = Hive.box('likedVideos');

    List<LikedVideo> lists = [];

    for (var item in box.values) {
      if (item is LikedVideo && File(item.videoFile).existsSync()) {
        lists.add(item); // Safely cast and add to the list
      }
    }
    lists.sort((a, b) => a.favoriteTime.compareTo(b.favoriteTime));

    return lists;
  }
}
