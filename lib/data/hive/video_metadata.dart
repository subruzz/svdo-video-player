import 'package:hive_flutter/adapters.dart';

class VideoDurationDb {
  static  Box box=Hive.box('video_duration');
 

  static Future<void> addVideo(String path, double time) async {
    await box.put(path, time);
  }

  static List getAllPaths() {
    return box.keys.toList();
  }

  static double getTime(String path)  {
    return  box.get(path);
  }
}