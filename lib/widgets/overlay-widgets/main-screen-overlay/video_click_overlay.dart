import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/util-classes/styling/app_colors.dart';
import 'package:svdomain/widgets/overlay-widgets/main-screen-overlay/video_click_overlay_items.dart';
import 'package:svdomain/provider/liked_videos_provider.dart';
import 'package:svdomain/provider/video-providers/video_information_provider.dart';
import 'package:svdomain/screens/add_to_playlist.dart';
import 'package:svdomain/screens/video_information.dart';
import 'package:svdomain/screens/video_playing_screen.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class MainScreenOverlay extends ConsumerWidget {
  const MainScreenOverlay(
      {super.key, required this.allvideos, required this.index});
  final List<String> allvideos;
  final int index;

  void playVideo(BuildContext context, List<String> allVideos, int index) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => VideoPlayingScreen(
          video: allvideos,
          index: index,
          videoTitle: VideoDetailsGenerate.getVideoName(allvideos[index]),
        ),
      ),
    );
  }

  void addPlaylist(BuildContext context, String videoPath, WidgetRef ref) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddToPlayListScreen(
          videoPath: allvideos[index],
        ),
      ),
    );
  }

  void addToFav(BuildContext context, WidgetRef ref) {
    final isAlready = ref.read(likedVideosProvider.notifier).addtToLiked(
          LikedVideo(
            videoFile: allvideos[index],
            favoriteTime: DateTime.now(),
          ),
        );
    isAlready
        ? TopSnackBar.showCustomSnackBarInfo(
            context, 'Item Already Exist  In your Favorites collection')
        : TopSnackBar.showCustomSnackBarSuccess(
            context, 'Successfully added to your Favorites collection');
    Navigator.pop(context);
  }

  void videoInfo(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(videoDetailsProvider.notifier)
          .getVideoInfo(allvideos[index]);
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const VideoInformation(),
          ),
        );
      }
    } catch (error) {
      // Handle errors gracefully
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.popupItemColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: screenHeight / 2.8, // Set the height as needed
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            MainScreenOverlayitems(
                title: 'Play video',
                icon: Icons.play_circle_outline_rounded,
                itemClick: () => playVideo(context, allvideos, index)),
            const SizedBox(
              height: 15,
            ),
            MainScreenOverlayitems(
              itemClick: () => addPlaylist(context, allvideos[index], ref),
              title: 'Add to Playlist',
              icon: Icons.playlist_add,
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            // MainScreenOverlayitems(
            //   title: 'Trim Video',
            //   icon: Icons.content_cut,
            //   itemClick: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (ctx) => TrimmerView(file: allvideos[index]),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(
              height: 15,
            ),
            MainScreenOverlayitems(
              title: 'Favorite',
              icon: Icons.favorite,
              itemClick: () => addToFav(context, ref),
            ),
            const SizedBox(
              height: 15,
            ),
            MainScreenOverlayitems(
              itemClick: () async => videoInfo(context, ref),
              title: 'Information',
              icon: Icons.info_outlined,
            )
          ],
        ),
      ),
    );
  }
}
