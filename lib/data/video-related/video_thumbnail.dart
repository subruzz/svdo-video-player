import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:video_compress/video_compress.dart';

class VideoThumbnail {
  static final Directory _thumbnailDir = Directory(
      '/storage/emulated/0/Android/data/com.example.svdomain/files/video_compress');

  static Future<String?> loadThumbnail(String path) async {
    bool isAlreadyPresent = false;
    String name = '${path.split('/').last.split('.').first}.jpg';

    final bool isFolderPresent = _thumbnailDir.existsSync();
    if (isFolderPresent) {
      //if the folder is present checking if thumbnail is present
      isAlreadyPresent = _isThumbnailPresent(name);
    }
    if (!isAlreadyPresent) {
      //if the thumbnail isn't present then
      await _generateThumbnail(path);
    }

    if (File('${_thumbnailDir.path}/$name').existsSync()) {
      //returning the path of the thumbnail
      return '${_thumbnailDir.path}/$name';
    }
    return null;
  }

  static bool _isThumbnailPresent(String name) {
    bool isPresent = false;
    _thumbnailDir.listSync().forEach((element) {
      //checking every file in the folder if the thumbnail is present
      if (element.path.split('/').last == name) {
        isPresent = true;
      }
    });
    return isPresent;
  }

  static Future<void> _generateThumbnail(String path) async {
    //this is to making thumbnail of the videos
    try {
      await VideoCompress.getFileThumbnail(
        path,
        quality: 25, //quality needed for the thumbnail
        position: -1,
         //position of the video where it want to make thumbnail
      );
    } catch (e) {
      debugPrint('The problem is in genrating thumbnail $e');
    }
  }
}
