import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:svdomain/data/hive/playlists.dart';
import 'package:svdomain/data/models/playlists_data.dart';

class PlaylistProvider extends StateNotifier<List<PlayListModels>> {
  PlaylistProvider() : super(PlaylistDb.getPlaylists());
  void _updateState() {
    state = PlaylistDb.getPlaylists();
  }

  bool addPlayListName(String playlistTitle, List<String>? videos) {
    final isAlreadyExist = PlaylistDb.addPlayListName(playlistTitle, videos);
    if (!isAlreadyExist) _updateState();
    return isAlreadyExist;
  }

  void addToPlaylist(List<String> videoPaths, String videoPath) {
    PlaylistDb.addToPlaylist(videoPaths, videoPath);
    _updateState();
  }

  void deleteVideo(String path, var key) {
    PlaylistDb.deleteVideo(path, key);
    _updateState();
  }

  void deletePlaylist(var key) {
    PlaylistDb.deletePlaylist(key);
    _updateState();
  }

  bool renamePlaylist(var key, String newName) {
    final bool alreadyExist = PlaylistDb.renamePlaylist(key, newName);
    _updateState();
    return alreadyExist;
  }
  
}

final playListProvider =
    StateNotifierProvider<PlaylistProvider, List<PlayListModels>>(
        (ref) => PlaylistProvider());
