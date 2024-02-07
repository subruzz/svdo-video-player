import 'package:flutter/material.dart';
import 'package:svdomain/data/video-related/video_thumbnail.dart';
import 'package:svdomain/widgets/overlay-widgets/main-screen-overlay/video_click_overlay.dart';
import 'package:svdomain/widgets/video-info/video_duration.dart';
import 'package:svdomain/widgets/video-info/video_thumbnail.dart';

class MainVideoMetaData extends StatelessWidget {
  const MainVideoMetaData(
      {super.key,
      required this.videoPath,
      required this.allVideos,
      required this.width,
      required this.index});
  final String videoPath;
  final List<String> allVideos;
  final double width;

  final int index;
  openVideoDetailsOverlay(
      int index, BuildContext context, List<String> allVideos) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return MainScreenOverlay(
          allvideos: allVideos,
          index: index,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: VideoThumbnail.loadThumbnail(videoPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Image.asset(
              'assets/images/applogo.png',
              width: 200,
              height: 100,
            );
          } else {
            return Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: snapshot.data != null
                        ? MainVideoThumbnail(videoPath: videoPath, width: width)
                        : const SizedBox(
                            width: 200,
                            height: 100,
                          )),
                Positioned(
                  right: -10,
                  top: -5,
                  child: IconButton(
                    onPressed: () {
                      openVideoDetailsOverlay(index, context, allVideos);
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      size: 30,
                    ),
                  ),
                ),
                MainVideoDuration(videoPath: videoPath)
              ],
            );
          }
        });
  }
}
