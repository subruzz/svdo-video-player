
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/models/liked_video.dart';
import 'package:svdomain/data/models/playlists_data.dart';
import 'package:svdomain/data/video-related/video_details.dart';

import 'package:svdomain/provider/liked_videos_provider.dart';
import 'package:svdomain/provider/playlists-providers/playlist_provider.dart';
import 'package:svdomain/screens/add_to_playlist.dart';
import 'package:svdomain/screens/video_playing_screen.dart';
import 'package:svdomain/widgets/helping-widgets/inside-playlist/playlist_video_items.dart';
import 'package:svdomain/widgets/helping-widgets/inside-playlist/playlist_empty_widget.dart';
import 'package:svdomain/widgets/snackbars/top_snackbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InsidePlaylist extends ConsumerStatefulWidget {
  const InsidePlaylist({super.key, required this.name, this.page});
  final String name;
  final String? page;
  @override
  ConsumerState<InsidePlaylist> createState() => _InsidePlaylistState();
}

class _InsidePlaylistState extends ConsumerState<InsidePlaylist> {
  PlayListModels? selectedPlaylist;
  List<PlayListModels> playlists = [];
  List<LikedVideo> likedVideos = [];
  void _playVideo(
    List<String> videos,
    int index,
    BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => VideoPlayingScreen(
          video: videos,
          index: index,
          videoTitle: VideoDetailsGenerate.getVideoName(videos![index]),
        ),
      ),
    );
  }

  void _removeFromLiked(int index, List<LikedVideo> likedVideoss) {
    ref
        .read(likedVideosProvider.notifier)
        .deleteFromLiked(likedVideoss[index].key);
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        message: "Video Removed From Liked Videos",
      ),
    );
  }

  void deleteFromPlaylist(int index, PlayListModels selectedPlaylist) {
    ref.read(playListProvider.notifier).deleteVideo(
          selectedPlaylist.pVideos[index],
          selectedPlaylist.key,
        );
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        message: "Video Removed From The Playlist ",
      ),
    );
  }

  void addToPlaylist(String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddToPlayListScreen(videoPath: videoPath),
      ),
    );
  }

  void addToLiked(String videoPath) {
    final isAlready = ref.read(likedVideosProvider.notifier).addtToLiked(
        LikedVideo(videoFile: videoPath, favoriteTime: DateTime.now()));
    isAlready
        ? TopSnackBar.showCustomSnackBarInfo(
            context, 'Video Already available in the Favorite collection')
        : TopSnackBar.showCustomSnackBarSuccess(
            context, 'Video Added To Favorite Collection');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.page == 'liked') {
      likedVideos = ref.watch(likedVideosProvider).reversed.toList();
    } else {
      playlists = ref.watch(playListProvider);
      selectedPlaylist =
          playlists.firstWhere((playlist) => playlist.pName == widget.name);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name, style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: widget.page == 'liked'
          ? likedVideos.isEmpty
              ? const PlalylistEmpty()
              : ListView.builder(
                  itemCount: likedVideos.length,
                  itemBuilder: ((context, index) => PlaylistVideoItem(
                      addVideo: () {
                        addToPlaylist(likedVideos[index].videoFile);
                      },
                      itemClick: () {
                        final videoPaths =
                            likedVideos.map((v) => v.videoFile).toList();

                        _playVideo(videoPaths, index, context);
                      },
                      removeVideo: () {
                        _removeFromLiked(index, likedVideos);
                      },
                      type: 'liked',
                      videoPath: likedVideos[index].videoFile)),
                )
          : selectedPlaylist == null || selectedPlaylist!.pVideos.isEmpty
              ? const PlalylistEmpty()
              : ListView.builder(
                  itemCount: selectedPlaylist!.pVideos.length,
                  itemBuilder: (ctx, index) => PlaylistVideoItem(
                      addVideo: () {
                        addToLiked(selectedPlaylist!.pVideos[index]);
                      },
                      itemClick: () {
                        _playVideo(selectedPlaylist!.pVideos, index, context);
                      },
                      removeVideo: () {
                        deleteFromPlaylist(index, selectedPlaylist!);
                      },
                      videoPath: selectedPlaylist!.pVideos[index])),
    );
  }
}
