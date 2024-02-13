
import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/widgets/helping-widgets/inside-playlist/popup_menu.dart';
import 'package:svdomain/widgets/video-info/video_duration.dart';
import 'package:svdomain/widgets/video-info/video_thumbnail.dart';

class PlaylistVideoItem extends StatelessWidget {
  const PlaylistVideoItem(
      {super.key,
      required this.itemClick,
      required this.removeVideo,
      this.type,
      required this.addVideo,
      required this.videoPath});
  final void Function() itemClick;
  final void Function() removeVideo;
  final void Function() addVideo;

  final String? type;
  final String videoPath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: itemClick,
        trailing: PlaylistItemPopUp(
          type: type ?? 'playlistIitems',
          removeVideo: removeVideo,
          addVideo: addVideo,
        ),
        // IconButton(
        //     onPressed: removeVideo, icon: const Icon(Icons.delete_sharp)),
        title: Text(
          VideoDetailsGenerate.getVideoName(videoPath),
          maxLines: 2,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        leading:Stack(
            children:[ MainVideoThumbnail(videoPath: videoPath, width: 100),
            MainVideoDuration(videoPath: videoPath)]
          ),
      ),
    );
  }
}
