import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:svdomain/provider/video-providers/video_provider.dart';

class SearchVideoProvider extends StateNotifier<List<String>> {
  final List<String> originalPaths;

  SearchVideoProvider(List<String> initialPaths)
      : originalPaths = List<String>.from(initialPaths),
        super(initialPaths);
  void onback() {
    state = originalPaths;
  }

  void runFilter(String enteredValue) {
    if (enteredValue.isEmpty) {
      state = List<String>.from(originalPaths);
    } else {
      state = originalPaths
          .where((element) => basename(element)
              .toLowerCase()
              .contains(enteredValue.toLowerCase()))
          .toList();
    }
  }
}

final searchVideoProvider =
    StateNotifierProvider<SearchVideoProvider, List<String>>((ref) {
  final videoPaths = ref.read(videoPathsProvider);
  return SearchVideoProvider(videoPaths);
});
