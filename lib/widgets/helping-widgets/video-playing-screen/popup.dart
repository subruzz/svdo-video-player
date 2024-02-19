import 'package:flutter/material.dart';

class VideoPlayingPopUp extends StatelessWidget {
  const VideoPlayingPopUp(
      {super.key, required this.addPlaylist, required this.addFav});
  final void Function() addPlaylist;

  final void Function() addFav;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (ctx) => [
              PopupMenuItem(
                onTap: addPlaylist,
                child: const Text(
                  'Add To Playlist',
                ),
              ),
              PopupMenuItem(
                child: const Text('Add to Favorite'),
                onTap: () {
                  addFav();
                },
              )
            ],
        icon: const Icon(Icons.more_vert_outlined));
  }
}
