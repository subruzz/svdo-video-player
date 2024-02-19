import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/provider/liked_videos_provider.dart';
import 'package:svdomain/screens/add_to_playlist.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class PopupMenuSearchScreen extends ConsumerWidget {
  const PopupMenuSearchScreen({super.key, required this.video});
  final String video;
  void addToFavorite(WidgetRef ref, BuildContext context) {
    final isLiked = ref.read(likedVideosProvider.notifier).addtToLiked(
        LikedVideo(videoFile: video, favoriteTime: DateTime.now()));
    if (isLiked) {
      TopSnackBar.showCustomSnackBarInfo(
          context, 'Video Is Already In Favorite Collection');
    } else {
      TopSnackBar.showCustomSnackBarSuccess(
          context, 'Video added Favorite Collection');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
        itemBuilder: (ctx) => [
              PopupMenuItem(
                  child: const Text(
                    'Add To Playlist',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => AddToPlayListScreen(videoPath: video),
                      ),
                    );
                  }),
              PopupMenuItem(
                child: const Text('Add to Favorites'),
                onTap: () {
                  addToFavorite(ref, context);
                },
              )
            ],
        icon: const Icon(Icons.more_vert_outlined));
  }
}
