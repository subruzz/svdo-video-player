import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:svdomain/provider/playlists-providers/playlist_provider.dart';
import 'package:svdomain/provider/playlists-providers/search_playlist_provider.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:svdomain/widgets/dialog-box.dart/rename_playlist.dart';
import 'package:svdomain/widgets/helping-widgets/playlist-screen/playlist_items.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';
import 'package:svdomain/widgets/textfields.dart';

class SearchPlaylist extends ConsumerStatefulWidget {
  const SearchPlaylist({super.key, required this.index});
  final int index;
  @override
  ConsumerState<SearchPlaylist> createState() => _SearchPlaylistState();
}

class _SearchPlaylistState extends ConsumerState<SearchPlaylist> {
  final _renameController = TextEditingController();
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
  void renameClick(WidgetRef ref, var key, String previousName) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (ctx) => RenamePlaylistDialog(
          previousName: previousName,
          renameController: _renameController,
          renamePlaylist: () {
            renamePlaylist(key);
          }),
    );
    _renameController.clear();
  }

  final FocusNode _searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // _foundVideos = widget.videoDetails;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final playlists = ref.watch(searchPlaylistProvider);
    return PopScope(
      onPopInvoked: (value) {
        ref.read(searchPlaylistProvider.notifier).onBack();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Image.asset(
                      'assets/images/applogo.png',
                      width: 120,
                      color: AppColors.imageColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: SizedBox(
                      height: 80,
                      child: TextfieldForSearch(
                        text: 'Search Playlists...',
                        focusNode: _searchFocusNode,
                        ref: ref,
                        index: widget.index,
                      )),
                ),
                playlists.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Lottie.asset(
                                'assets/images/Animation - 1707131269098 (1).json'),
                            const Text('No Playlist Found'),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: playlists.length,
                            itemBuilder: (ctx, index) => PlayListItems(
                                renamePlaylist: () {
                                  renameClick(ref, playlists[index].key,
                                      playlists[index].pName);
                                },
                                deletePlaylist: () {
                                  deletePlaylist(ref, playlists[index].key);
                                },
                                name: playlists[index].pName,
                                videos: playlists[index])),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
