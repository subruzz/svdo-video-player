import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class FetchVideos {
  static Future<void> requestPermission() async {
    PermissionStatus permissionStatus;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    int version = int.parse(androidInfo.version.release);
    permissionStatus = version >= 13
        ? await Permission.videos.request()
        : await Permission.storage.request();
    if (permissionStatus.isGranted) {
      // _navigateToMainScreen();
    } else {
      openAppSettings();
    }
  }

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

    if (sdkVersion >= 31) {
      Directory root = Directory('/storage/emulated/0/Android');
      root.listSync().forEach((element) {
        paths.add(element.path);
      });
      root = Directory('/storage/emulated/0');
      root.listSync().forEach((element) {
        if (isVideoFile(element.path) && element.existsSync()) {
          videoPaths.add(element.path);
        } else {
          paths.add(element.path);
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
            videoPaths.add(element.path);
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
            videoPaths.add(entity.path);
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
