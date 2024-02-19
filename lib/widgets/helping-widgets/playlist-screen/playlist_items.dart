import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:svdomain/data/models/playlists_data.dart';
import 'package:svdomain/screens/inside_playlist.dart';
import 'package:svdomain/widgets/helping-widgets/playlist-screen/playlist_popover.dart';

class PlayListItems extends StatelessWidget {
  const PlayListItems(
      {super.key,
    required  this.renamePlaylist,
      required this.name,
      required this.videos,
      required this.deletePlaylist});
  final String name;
  final PlayListModels videos;
  final void Function() deletePlaylist;
  final void Function() renamePlaylist;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        PlaylistPopover.showPopOver(context, deletePlaylist, renamePlaylist);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => InsidePlaylist(
              name: name,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Lottie.asset(
                  'assets/images/Animation - 1705728223899.json',
                  width: 50,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${videos.pVideos.length.toString()} Videos',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
