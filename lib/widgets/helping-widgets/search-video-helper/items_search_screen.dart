import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/screens/video_playing_screen.dart';
import 'package:svdomain/widgets/helping-widgets/search-video-helper/popup_menu.dart';
import 'package:svdomain/widgets/video-info/video_duration.dart';
import 'package:svdomain/widgets/video-info/video_thumbnail.dart';

class SearchItems extends ConsumerWidget {
  const SearchItems(
      {super.key,
      required this.video,
      required this.index,
      required this.foundVideos});
  final String video;
  final int index;
  final List<String> foundVideos;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          leading:Stack(
            children:[ MainVideoThumbnail(videoPath: video, width: 100),
            MainVideoDuration(videoPath: video)]
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => VideoPlayingScreen(
                    singleVideo: video,
                    videoTitle: VideoDetailsGenerate.getVideoName(video),
                    index: index,
                  ),
                ));
          },
          trailing: PopupMenuSearchScreen(video: video),
          title: Text(
            VideoDetailsGenerate.getVideoName(video),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ));
  }
}
