import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrimmedVideoProvider extends StateNotifier<List<String>> {
  TrimmedVideoProvider() : super([]);
  Future getVideos() async {
    List<String> trimmedPath = [];
    final Directory trimmedVideoDir = Directory(
        '/storage/emulated/0/Android/data/com.example.svdomain/files/trimmedVideos');
    if (trimmedVideoDir.existsSync()) {
      trimmedVideoDir.listSync().forEach((element) {
        if (isVideoFile(element.path) && element.existsSync()) {
          trimmedPath.add(element.path);
        }
      });
    }
    state = trimmedPath;
  }

  bool isVideoFile(String file) {
    final String extension = file.split('.').last.toLowerCase();
    return (extension == 'mp4' ||
            extension == 'mov' ||
            extension == 'avi' ||
            extension == 'mkv') &&
        !file.split('/').last.startsWith('.trashed');
  }

  void afterTrimming(String file) {
    final List<String> paths = List.from(state);
    paths.add(file);
    state = paths;
  }
}

final trimmedVideoProvider =
    StateNotifierProvider<TrimmedVideoProvider, List<String>>(
        (ref) => TrimmedVideoProvider());
