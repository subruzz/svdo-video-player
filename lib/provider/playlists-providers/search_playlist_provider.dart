import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/models/playlists_data.dart';
import 'package:svdomain/provider/playlists-providers/playlist_provider.dart';

class SearchPlaylistProvider extends StateNotifier<List<PlayListModels>> {
  final List<PlayListModels> originalPaths;

  SearchPlaylistProvider(List<PlayListModels> initialPaths)
      : originalPaths = List<PlayListModels>.from(initialPaths),
        super(initialPaths);

  void runFilter(String enteredValue) {
    if (enteredValue.isEmpty) {
      state = List<PlayListModels>.from(originalPaths);
    } else {
      state = originalPaths
          .where((element) =>
              element.pName.toLowerCase().contains(enteredValue.toLowerCase()))
          .toList();
    }
  }

  void onBack() {
    state = originalPaths;
  }
}

final searchPlaylistProvider =
    StateNotifierProvider<SearchPlaylistProvider, List<PlayListModels>>((ref) {
  final playlists = ref.watch(playListProvider);
  return SearchPlaylistProvider(playlists);
});
