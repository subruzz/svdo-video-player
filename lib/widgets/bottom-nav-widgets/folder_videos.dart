import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/provider/folder-providers/filter_folder_provider.dart';
import 'package:svdomain/provider/folder-providers/folder_provider.dart';
import 'package:svdomain/screens/inside_folder_videos.dart';
import 'package:svdomain/widgets/helping-widgets/folder/each_folder.dart';

class FolderVideos extends ConsumerWidget {
  const FolderVideos({
    super.key,
  });
    void onFolderClick(
      String folder, BuildContext context, WidgetRef ref) {
    ref.read(filterFolder.notifier).filterFolder(folder, ref);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => InsideFolderVideos(
          folder: VideoDetailsGenerate.getVideoName(folder),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(videoFolderProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) => EachFolder(
          folder: VideoDetailsGenerate.getVideoName(folders[index]),
          onFolderClick: () {
       onFolderClick(folders[index], context, ref);
          },
        ),
      ),
    );
  }
}
