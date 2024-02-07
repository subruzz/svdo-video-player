import 'package:flutter/material.dart';
import 'package:svdomain/widgets/dialog-box.dart/create_playlist.dart';

class PlaylistTopDetails extends StatelessWidget {
  const PlaylistTopDetails(
      {super.key,
      required this.createPlaylist,
      required this.noOfPlaylist,
      required this.titleController});
  final int noOfPlaylist;
  final void Function() createPlaylist;
  final TextEditingController titleController;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$noOfPlaylist Playlist',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) => AddPlaylistDialog(
                    nameController: titleController,
                    createPlaylist: createPlaylist));
          },
          icon: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ],
    );
  }
}
