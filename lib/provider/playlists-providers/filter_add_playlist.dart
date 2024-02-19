import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/models/playlists_data.dart';
import 'package:svdomain/provider/playlists-providers/playlist_provider.dart';

class FilterAddPlaylist extends StateNotifier<List<PlayListModels>> {
  List<PlayListModels> availaleItems = [];
  FilterAddPlaylist(List<PlayListModels> availablePlaylists)
      : availaleItems = availablePlaylists,
        super(availablePlaylists);
  void onback() {
    state = List.from(availaleItems);
  }

  void runFilter(String enteredValue) {
    if (enteredValue.isEmpty) {
      state = List<PlayListModels>.from(availaleItems);
    } else {
      state = availaleItems
          .where((element) =>
              element.pName.toLowerCase().contains(enteredValue.toLowerCase()))
          .toList();
    }
  }
}

final filterAddPlaylist =
    StateNotifierProvider<FilterAddPlaylist, List<PlayListModels>>((ref) {
  final availablePlaylists = ref.watch(playListProvider);
  return FilterAddPlaylist(availablePlaylists);
});
