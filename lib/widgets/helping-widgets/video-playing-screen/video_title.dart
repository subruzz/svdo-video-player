import 'dart:io';

import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/screens/add_to_playlist.dart';
import 'package:svdomain/widgets/helping-widgets/video-playing-screen/popup.dart';

class VideoTitle extends StatelessWidget {
  const VideoTitle({super.key, required this.file, required this.addToLiked});
  final String file;
  final void Function(String file) addToLiked;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        File(file).existsSync()
            ? VideoPlayingPopUp(addPlaylist: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            AddToPlayListScreen(videoPath: file)));
              }, addFav: () {
                addToLiked(file);
              })
            : const SizedBox()
      ],
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        VideoDetailsGenerate.getVideoName(file),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
