import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/provider/folder-providers/filter_folder_provider.dart';
import 'package:svdomain/widgets/helping-widgets/allvideo-screen/each_video.dart';

class InsideFolderVideos extends ConsumerWidget {
  const InsideFolderVideos({
    super.key,
    required this.folder,
  });
  final String folder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderVideos = ref.watch(filterFolder);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(folder),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0, // Maximum width for each item
                  childAspectRatio: .9,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: folderVideos.length,
                itemBuilder: ((context, index) {
                  return EachVideoItem(
                    allVideos: folderVideos,
                    index: index,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
