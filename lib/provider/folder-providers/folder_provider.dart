import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:svdomain/provider/video-providers/video_provider.dart';
import 'package:svdomain/data/video-related/folder_details.dart';

final videoFolderProvider = Provider<List<String>>((ref) {
  final videoPaths = ref.read(videoPathsProvider);
  final folders = FolderDetails.getFolders(videoPaths).toList();
  final sortedFolders = List<String>.from(folders);
  sortedFolders.sort(
    (a, b) => basename(a).toLowerCase().compareTo(
          basename(b).toLowerCase(),
        ),
  );
  return sortedFolders;
});
