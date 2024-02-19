import 'dart:io';

import 'package:hive/hive.dart';
import 'package:svdomain/data/models/playlists_data.dart';

class PlaylistDb {
  static Box box = Hive.box('userPlaylist');
//to get the all playlist
  static List<PlayListModels> getPlaylists() {
    try {
      List<PlayListModels> lists = [];

      for (var item in box.values) {
        if (item is PlayListModels) {
          final List<String> videoPaths = item.pVideos;
          // Create a new list to store existing video paths
          List<String> existingVideoPaths = [];

          // Iterate through each video path and check if it exists
          for (var i in videoPaths) {
            if (File(i).existsSync()) {
              existingVideoPaths.add(i); // Add existing paths to the new list
            }
          }

          // Update the pVideos property of the PlayListModels object
          item.pVideos = existingVideoPaths;

          lists.add(item); // Safely cast and add to the list
        }
      }
      return lists;
    } catch (e) {
      return [];
    }
  }

//this is for adding name for the playlist when user first create a playlist
  static bool addPlayListName(String playlistTitle, List<String>? videos) {
    try {
      bool playlistAlreadyExist =
          box.values.any((playlist) => playlist.pName == playlistTitle);

      if (playlistAlreadyExist) {
        return true;
      } else {
        PlayListModels item =
            PlayListModels(pName: playlistTitle, pVideos: videos ?? []);
        box.add(item);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//after creating playlist this for adding to the list to store playlist videos
  static void addToPlaylist(List<String> videoPaths, String videoPath) {
    try {
      for (var item in videoPaths) {
        PlayListModels findPlayList =
            box.values.firstWhere((playlist) => playlist.pName == item);
        var key = findPlayList.key;

        final List<String> list = findPlayList.pVideos;
        list.add(videoPath);
        box.put(key, PlayListModels(pVideos: list, pName: findPlayList.pName));
      }
    } catch (e) {
      return;
    }
  }

//to delete a particular video from the playlist
  static void deleteVideo(String path, var key) {
    try {
      PlayListModels item = box.get(key);

      List<String> videoPaths = item.pVideos;
      videoPaths.remove(path);
      box.put(key, PlayListModels(pName: item.pName, pVideos: videoPaths));
    } catch (e) {
      return;
    }
  }

// to completely delte a playlist from the hive
  static void deletePlaylist(var key) {
    try {
      box.delete(key);
    } catch (e) {
      return;
    }
  }

//to rename the playlist
  static bool renamePlaylist(var key, String newName) {
    try {
      bool playlistAlreadyExist =
          box.values.any((playlist) => playlist.pName == newName);
      if (playlistAlreadyExist) {
        return true;
      } else {
        PlayListModels item = box.get(key);
        box.put(key, PlayListModels(pName: newName, pVideos: item.pVideos));

        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
