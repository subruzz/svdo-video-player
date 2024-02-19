import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/video-providers/video_provider.dart';
import 'package:svdomain/widgets/helping-widgets/allvideo-screen/each_video.dart';
import 'package:svdomain/widgets/helping-widgets/inside-playlist/playlist_empty_widget.dart';

class AllVideoDisplay extends ConsumerStatefulWidget {
  const AllVideoDisplay({
    super.key,
  });

  @override
  ConsumerState<AllVideoDisplay> createState() => _AllVideoDisplayState();
}

class _AllVideoDisplayState extends ConsumerState<AllVideoDisplay> {
  @override
  Widget build(BuildContext context) {
    final videoPaths = ref.watch(videoPathsProvider);
    return videoPaths.isNotEmpty
        ? Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0, // Maximum width for each item
                childAspectRatio: 1,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: videoPaths.length,
              itemBuilder: ((context, index) {
                return EachVideoItem(
                  key: ValueKey(videoPaths[index]),
                  allVideos: videoPaths,
                  // openVideoDetailsOverlay: openVideoDetailsOverlay,
                  index: index,
                );
              }),
            ),
          )
        : const Center(
            child: PlalylistEmpty(),
          );
  }
}
