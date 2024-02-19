import 'dart:io';

import 'package:hive/hive.dart';
import 'package:svdomain/data/models/recently_watched.dart';

class RecentDb {
  static Box box = Hive.box('recents');

  /*here it is to add to recent if it already exist in the recent 
    we remove it and add it again to get that video as the last played*/
  static bool addToRecent(RecentVideos recent) {
    bool videoAlreadyExist = box.values
        .cast<RecentVideos>()
        .any((v) => v.videoFile == recent.videoFile);
    if (videoAlreadyExist) {
      RecentVideos foundItem = box.values
          .cast<RecentVideos>()
          .firstWhere((v) => v.videoFile == recent.videoFile);
      box.delete(foundItem.key);
      box.add(recent);

      return true;
    } else {
      box.add(recent);

      return false;
    }
  }

  //to delete from the hive
  static void deleteFromRecents(var key) async {
    await box.delete(key);
  }

  static Future<void> clearRecnet()async {
  await   box.clear();
  }

  //to get all the recent from the hive
  static List<RecentVideos> getRecents() {
    List<RecentVideos> lists = [];
    for (var item in box.values) {
      if (item is RecentVideos && File(item.videoFile).existsSync()) {
        lists.add(item); // Safely cast and add to the list
      }
    }
    lists.sort((a, b) => a.recentTime.compareTo(b.recentTime));

    return lists;
  }
}
