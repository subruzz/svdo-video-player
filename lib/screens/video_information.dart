
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svdomain/data/video-related/video_duration.dart';
import 'package:svdomain/provider/video-providers/video_information_provider.dart';
import 'package:svdomain/data/video-related/video_details.dart';
import 'package:svdomain/widgets/helping-widgets/video_click_overlay_helper.dart/video-info-items/video_info_items.dart';
import 'package:svdomain/widgets/video-info/video_thumbnail.dart';

class VideoInformation extends ConsumerWidget {
  const VideoInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoDetail = ref.watch(videoDetailsProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: screenHeight / 3,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  videoDetail.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                background: MainVideoThumbnail(
                  videoPath: videoDetail.path!,
                  width: double.infinity,
                  height: 300,
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoInformationItems(
                    title: 'Name:  ',
                    value: videoDetail.title!,
                  ),
                  const SizedBox(height: 10),
                  VideoInformationItems(
                    title: 'Type:  ',
                    value: VideoDetailsGenerate.getVideoName(
                        videoDetail.path!),
                  ),
                  const SizedBox(height: 10),
                  VideoInformationItems(
                      title: 'Duration:  ',
                      value: VideoDuration.videoDuration(
                          videoDetail.duration ?? 0.0)),
                  const SizedBox(height: 10),
                  VideoInformationItems(
                      title: 'Path:  ',
                      value: videoDetail.path ?? 'could not find path'),
                  const SizedBox(height: 10),
                  // VideoInformationItems(
                  //     title: 'Date:  ', value: videoDetail.date!),
                  const SizedBox(height: 10),
                  VideoInformationItems(
                      title: 'Size:  ',
                      value: VideoDetailsGenerate.getFileSizeString(
                          bytes: videoDetail.filesize ?? 00)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
          ),
        ],
      ),
    );
  }
}
