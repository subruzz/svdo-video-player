import 'package:flutter/material.dart';
import 'package:svdomain/data/models/recently_watched.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/screens/video_playing_screen.dart';
import 'package:svdomain/widgets/helping-widgets/recnently_played/recent_progress.dart';
import 'package:svdomain/widgets/helping-widgets/recnently_played/recent_video_details.dart';
import 'package:svdomain/widgets/video-info/video_thumbnail.dart';

class RecnentItems extends StatelessWidget {
  const RecnentItems(
      {super.key,
      required this.recentVideo,
      required this.addToLiked,
      required this.index,
      required this.removeFromRecent,
      required this.addToPlayList});
  final RecentVideos recentVideo;
  final int index;
  final void Function() addToPlayList;
  final void Function() addToLiked;
  final void Function() removeFromRecent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => VideoPlayingScreen(
                    singleVideo: recentVideo.videoFile,
                    index: index,
                    videoTitle: VideoDetailsGenerate.getVideoName(
                        recentVideo.videoFile),
                  ),
                ),
              );
            },
            title: Text(
              VideoDetailsGenerate.getVideoName(recentVideo.videoFile),
              maxLines: 2,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            trailing: PopupMenuButton(
                itemBuilder: (ctx) => [
                      PopupMenuItem(
                        onTap: addToLiked,
                        child: const Text(
                          'Add To Favorites',
                        ),
                      ),
                      PopupMenuItem(
                        onTap: addToPlayList,
                        child: const Text('Add To Playlist'),
                      ),
                      PopupMenuItem(
                        onTap: removeFromRecent,
                        child: const Text(
                          'Remove From Recent',
                        ),
                      ),
                    ],
                icon: const Icon(Icons.more_vert_outlined)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(children: [
                MainVideoThumbnail(
                    videoPath: recentVideo.videoFile, width: 100),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: RecentProgress(recentVideo: recentVideo),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RecentVideoData(recentVideo: recentVideo),
        ],
      ),
    );
  }
}
