import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:svdomain/data/video-related/get_videos.dart';

class VideoProvider extends StateNotifier<List<String>> {
  VideoProvider() : super([]);
  Future getVideos() async {
    PermissionStatus permissionStatus;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    int version = int.parse(androidInfo.version.release);
    permissionStatus = version >= 13
        ? await Permission.videos.request()
        : await Permission.storage.request();
    if (permissionStatus.isGranted) {
      await FetchVideos.getVideoPathsAsync().then((value) {
        state = value;
      });
    } else {
      openAppSettings();
    }
  }

  void sortByName(bool sort) {
    final List<String> paths = List.from(state);
    paths.sort((a, b) {
      final String first = a.split('/').last;
      final String second = b.split('/').last;
      if (sort) {
        
        return first.compareTo(second);
        
      } else {
        return second.compareTo(first);
      }
    });

    state = List.from(paths);
  }

  void sortBySize(bool sort) {
    final List<String> paths = List.from(state);
    paths.sort((a, b) {
      final File first = File(a);
      final File second = File(b);
      if (sort) {
        return first.lengthSync().compareTo(second.lengthSync());
      } else {
        return second.lengthSync().compareTo(first.lengthSync());
      }
    });

    state = List.from(paths);
  }
}

final videoPathsProvider = StateNotifierProvider<VideoProvider, List<String>>(
    (ref) => VideoProvider());

final sortByNameProvider = StateProvider((ref) => true);
final sortBySizeProvider = StateProvider((ref) => true);

