import 'package:flutter/material.dart';

class PlaylistItemPopUp extends StatelessWidget {
  const PlaylistItemPopUp(
      {super.key,
      required this.removeVideo,
      required this.type,
      required this.addVideo});
  final void Function() removeVideo;
  final String type;
  final void Function() addVideo;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (ctx) => [
              PopupMenuItem(
                onTap: addVideo,
                child: Text(
                  type == 'liked' ? 'Add To Playlist' : 'Add To Favorite',
                ),
              ),
              PopupMenuItem(
                child: const Text('Remove Video'),
                onTap: () {
                  removeVideo();
                },
              )
            ],
        icon: const Icon(Icons.more_vert_outlined));
  }
}
