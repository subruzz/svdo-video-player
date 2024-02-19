import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:video_compress/video_compress.dart';

class VideoDetailsProvider extends StateNotifier<MediaInfo> {
  VideoDetailsProvider() : super(MediaInfo(path: null));

  Future<void> getVideoInfo(String videoPath) async {
    // final videoInfo = FlutterVideoInfo();
    final videoInfo = await VideoCompress.getMediaInfo(videoPath);
    videoInfo.title = VideoDetailsGenerate.getVideoName(videoPath);
    state = videoInfo;
  }
}

final videoDetailsProvider =
    StateNotifierProvider<VideoDetailsProvider, MediaInfo>(
        (ref) => VideoDetailsProvider());
