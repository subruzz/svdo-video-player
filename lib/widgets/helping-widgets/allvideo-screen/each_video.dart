import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/screens/video_playing_screen.dart';
import 'package:svdomain/widgets/video-info/video_metadata.dart';

class EachVideoItem extends StatelessWidget {
  const EachVideoItem(
      {super.key, required this.index, required this.allVideos});
  final List<String> allVideos;
  final int index;

  void goToPlayVideoScreen(
      List<String> video, BuildContext context, String videoTitle) {
        
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => VideoPlayingScreen(
          videoTitle: VideoDetailsGenerate.getVideoName(videoTitle),
          video: video,
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentVideo = allVideos[index];
    return GestureDetector(
      onTap: () {
        goToPlayVideoScreen(allVideos, context, currentVideo);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainVideoMetaData(
            videoPath: allVideos[index],
            allVideos: allVideos,
            index: index,
            width: 200,
          ),
          Text(
            VideoDetailsGenerate.getVideoName(allVideos[index]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
