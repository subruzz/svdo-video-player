import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/playlists-providers/filter_add_playlist.dart';
import 'package:svdomain/provider/playlists-providers/playlist_provider.dart';
import 'package:svdomain/widgets/dialog-box.dart/create_playlist.dart';
import 'package:svdomain/widgets/helping-widgets/add-to-playlist-screen/button.dart';
import 'package:svdomain/widgets/helping-widgets/add-to-playlist-screen/textfield.dart';
import 'package:svdomain/widgets/helping-widgets/playlist-screen/check_playlist.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class AddToPlayListScreen extends ConsumerStatefulWidget {
  const AddToPlayListScreen({super.key, required this.videoPath});
  final String videoPath;

  @override
  ConsumerState<AddToPlayListScreen> createState() =>
      _AddToPlayListScreenState();
}

class _AddToPlayListScreenState extends ConsumerState<AddToPlayListScreen> {
  final _titleController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  final List<String> _selectedItems = [];
  void _onCheck(bool value, String title) {
    if (value) {
      _selectedItems.add(title);
    } else {
      _selectedItems.remove(title);
    }
  }

  void _createPlaylist(String videoPath) {
    final isAlreadyExist = ref
        .read(playListProvider.notifier)
        .addPlayListName(_titleController.text, [videoPath]);

    _titleController.clear();

    if (isAlreadyExist) {
      TopSnackBar.showCustomSnackBarError(context, 'Playlist Already Exist');
    } else {
      TopSnackBar.showCustomSnackBarSuccess(
        context,
        'Video Added To ${_titleController.text}',
      );
      ref.read(filterAddPlaylist.notifier).onback();

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void _addToPlaylist() {
    if (_selectedItems.isNotEmpty) {
      ref
          .read(playListProvider.notifier)
          .addToPlaylist(_selectedItems, widget.videoPath);
      TopSnackBar.showCustomSnackBarSuccess(
          context, 'Video Successfully Added to Playlists');
    }
    ref.read(filterAddPlaylist.notifier).onback();
    Navigator.pop(context);
  }

  void _showCreatePlaylist() {
    showDialog(
      context: context,
      builder: (ctx) => AddPlaylistDialog(
          nameController: _titleController,
          createPlaylist: () {
            _createPlaylist(widget.videoPath);
          }),
    );
  }

  void _runFilter(String value) {
    ref.read(filterAddPlaylist.notifier).runFilter(value);
  }

  @override
  Widget build(BuildContext context) {
    final playlists = ref.watch(playListProvider);
    final avaiablePlaylist = playlists
        .where((element) => !element.pVideos.contains(widget.videoPath))
        .toList();
   
    return PopScope(
      onPopInvoked: (value) {
        ref.read(filterAddPlaylist.notifier).onback();
      },
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: AddToPlaylistButton(
          addToPlaylist: _addToPlaylist,
          text: 'Done',
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add To Playlist',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: AddToPlaylistButton(
                  addToPlaylist: _showCreatePlaylist,
                  text: 'New Playlist',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AddToPlayListSearch(runFilter: _runFilter),
              const SizedBox(
                height: 20,
              ),
              avaiablePlaylist.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          'No PlayList Available To\n Add This Video',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: avaiablePlaylist.length,
                          itemBuilder: (ctx, index) => PlaylistItemCheck(
                                title: avaiablePlaylist[index].pName,
                                onCheck: _onCheck,
                              )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
