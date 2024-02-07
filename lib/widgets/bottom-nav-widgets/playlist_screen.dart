import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/liked_videos_provider.dart';
import 'package:svdomain/provider/playlists-providers/playlist_provider.dart';
import 'package:svdomain/widgets/dialog-box.dart/rename_playlist.dart';
import 'package:svdomain/widgets/helping-widgets/playlist-screen/liked_video_widget.dart';
import 'package:svdomain/widgets/helping-widgets/playlist-screen/playlist_items.dart';
import 'package:svdomain/widgets/helping-widgets/playlist-screen/top_details.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class PlayListScreen extends ConsumerStatefulWidget {
  const PlayListScreen({super.key});

  @override
  ConsumerState<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends ConsumerState<PlayListScreen> {
  final _titleController = TextEditingController();
  final _renameController = TextEditingController();
  //used to delete the playlist from hive
  void deletePlaylist(WidgetRef ref, var key) {
    ref.read(playListProvider.notifier).deletePlaylist(key);
    TopSnackBar.showCustomSnackBarInfo(context, 'Playlist has been deleted!');
  }

//rename the playlist
  void renamePlaylist(var key) {
    ref
        .read(playListProvider.notifier)
        .renamePlaylist(key, _renameController.text);
    Navigator.pop(context);
    TopSnackBar.showCustomSnackBarSuccess(
        context, 'Playlist Renamed To ${_renameController.text}');
  }

//when user clickthe rename popup
  void renameClick(WidgetRef ref, var key,String previousName) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (ctx) => RenamePlaylistDialog(
          renameController: _renameController,
          previousName: previousName,
          renamePlaylist: () {
            renamePlaylist(key);
          }),
    );
    _renameController.clear();
  }

  void createPlaylist() {
    final isAlreadyExist = ref
        .read(playListProvider.notifier)
        .addPlayListName(_titleController.text, null);
    
 
    if (isAlreadyExist) {
      TopSnackBar.showCustomSnackBarError(context, 'Playlist Already Exist');
    } else {
      TopSnackBar.showCustomSnackBarSuccess(
          context, 'New Playlist ${_titleController.text} created');
      Navigator.pop(context);

    }
    _titleController.clear();
  
  }

  @override
  void dispose() {
    _renameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playlists = ref.watch(playListProvider);
    final likedVideos = ref.watch(likedVideosProvider);

    return Expanded(
      child: Column(
        children: [
          PlaylistTopDetails(
              createPlaylist: createPlaylist,
              noOfPlaylist: playlists.length,
              titleController: _titleController),
          const SizedBox(
            height: 10,
          ),
          LikedVideoSingle(likedVideos: likedVideos),
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: ((context, index) => PlayListItems(
                    deletePlaylist: () {
                      deletePlaylist(ref, playlists[index].key);
                    },
                    renamePlaylist: () {
                      renameClick(ref, playlists[index].key,playlists[index].pName);
                    },
                    name: playlists[index].pName,
                    videos: playlists[index],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
