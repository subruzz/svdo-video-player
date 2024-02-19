import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/video-providers/video_provider.dart';

class FilterFolder extends StateNotifier<List<String>> {
  FilterFolder() : super([]);

  void filterFolder(String folder, WidgetRef ref) {

    final videoPaths = ref.read(videoPathsProvider);
    final folderVideos =
        videoPaths.where((element) => element.startsWith(folder)).toList();
    state = folderVideos;
  }
}

final filterFolder =
    StateNotifierProvider<FilterFolder, List<String>>((ref) => FilterFolder());
