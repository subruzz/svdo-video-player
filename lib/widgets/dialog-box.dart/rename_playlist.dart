import 'package:flutter/material.dart';

class RenamePlaylistDialog extends StatelessWidget {
  const RenamePlaylistDialog(
      {super.key,
      required this.renameController,
      required this.renamePlaylist,
      required this.previousName});
  final TextEditingController renameController;
  final void Function() renamePlaylist;
  final String previousName;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Rename Playlist'),
      actions: [
        TextField(
          decoration: InputDecoration(
            hintText: previousName,
          ),
          controller: renameController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(onPressed: renamePlaylist, child: const Text('ok'))
          ],
        ),
      ],
    );
  }
}
