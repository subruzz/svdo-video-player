import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/provider/liked_videos_provider.dart';
import 'package:svdomain/provider/theme-providers/settings_provider.dart';
import 'package:svdomain/provider/recently_watched_provider.dart';
import 'package:svdomain/screens/add_to_playlist.dart';
import 'package:svdomain/widgets/dialog/choice.dart';
import 'package:svdomain/widgets/helping-widgets/recnently_played/recent_items.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';

class RecentlyWatchedScreen extends ConsumerWidget {
  const RecentlyWatchedScreen({super.key});
  void addToPlaylist(String videoPath, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddToPlayListScreen(videoPath: videoPath),
      ),
    );
  }

  void addToLiked(String videoPath, BuildContext context, WidgetRef ref) {
    final isAlready = ref.read(likedVideosProvider.notifier).addtToLiked(
        LikedVideo(videoFile: videoPath, favoriteTime: DateTime.now()));
    isAlready
        ? TopSnackBar.showCustomSnackBarInfo(
            context, 'Video Already available in the Favorite collection')
        : TopSnackBar.showCustomSnackBarSuccess(
            context, 'Video Added To Favorite Collection');
  }

  void removeFromRecent(WidgetRef ref, var key, BuildContext context) {
    ref.read(recentlyWatchedProvider.notifier).deleteFromRecents(key);
    TopSnackBar.showCustomSnackBarInfo(context, 'Video Removed From Recents');
  }

  void clearRecent(BuildContext context, WidgetRef ref) {
    showDialog(context: context, builder: (ctx) => const ChoiceDialog());
  
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recents =
        ref.watch(recentlyWatchedProvider).reversed.toList().take(10).toList();
    final isRecentEnabled = ref.watch(settingsProvider)[Filter.showRecents];
    if (recents.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recently Watched',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No videos found',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                clearRecent(context, ref);
              },
              icon: const Icon(Icons.delete))
        ],
        title: Text(
          'Recently Watched',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: isRecentEnabled == null || isRecentEnabled
          ? ListView.builder(
              itemCount: recents.length,
              itemBuilder: (ctx, index) => RecnentItems(
                    recentVideo: recents[index],
                    index: index,
                    addToLiked: () {
                      addToLiked(recents[index].videoFile, context, ref);
                    },
                    addToPlayList: () {
                      addToPlaylist(recents[index].videoFile, context);
                    },
                    removeFromRecent: () {
                      removeFromRecent(ref, recents[index].key, context);
                    },
                  ))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/Animation - 1706808247318.json',
                      width: 300),
                  const Text(
                    'Recently watched cant be seen!. if you want to see enable them by going to settings',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
