import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class FetchVideos {
  // static Future<List<String>> getVideoPathsAsync() async {
  //   ListAllVideos object = ListAllVideos();
  //   // lists all videos in the device
  //   List<VideoDetails> videos = await object.getAllVideosPath();
  //   List<String> videoPaths = videos.map((video) => video.videoPath).toList();
  //   return videoPaths;
  // }
  static Future<List<String>> getVideoPathsAsync() async {
    bool isVideoFile(String file) {
      final String extension = file.split('.').last.toLowerCase();
      return (extension == 'mp4' ||
              extension == 'mov' ||
              extension == 'avi' ||
              extension == 'mkv') &&
          !file.split('/').last.startsWith('.trashed');
    }

    List<String> videoPaths = [];
    List<String> restrictedFiles = [
      '/storage/emulated/0/Android',
      '/storage/emulated/0/Android/obb',
      '/storage/emulated/0/Android/data'
    ];

    List<String> paths = [];
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = deviceInfo.version.sdkInt;

    // int videoCount = 0; // Counter for videos fetched

    if (sdkVersion >= 31) {
      Directory root = Directory('/storage/emulated/0/Android');
      root.listSync().forEach((element) {
        paths.add(element.path);
      });

      root = Directory('/storage/emulated/0');
      root.listSync().forEach((element) {
        if (element is Directory) {
          paths.add(element.path);
        } else if (isVideoFile(element.path) && element.existsSync()) {
          // if (videoCount < 60) {
          // Limit videos fetched to 5
          videoPaths.add(element.path);
          // videoCount++;
          // }
        }
      });

      for (final resPath in restrictedFiles) {
        if (paths.contains(resPath)) {
          paths.remove(resPath);
        }
      }
      for (final path in paths) {
        Directory root = Directory(path);
        root.listSync(recursive: true).forEach((element) {
          if (isVideoFile(element.path) && element.existsSync()) {
            // if (videoCount < 60) {
            // Limit videos fetched to 5
            videoPaths.add(element.path);
            // videoCount++;
            // }
          }
        });
      }
    } else {
      try {
        Directory root = Directory('/storage/emulated/0/');
        await for (final FileSystemEntity entity
            in root.list(recursive: true)) {
          if (entity is File &&
              isVideoFile(entity.path) &&
              entity.existsSync()) {
            // if (videoCount < 40) {
            // Limit videos fetched to 5
            videoPaths.add(entity.path);
            // videoCount++;
            // }
          }
        }
      } catch (e) {
        debugPrint('Error getting video files: $e');
        return [];
      }
    }
    return videoPaths;
  }
}
