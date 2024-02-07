import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svdomain/data/models/recently_watched.dart';

class RecentVideoData extends StatelessWidget {
  const RecentVideoData({super.key, required this.recentVideo});
  final RecentVideos recentVideo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Watched On:  ${DateFormat('dd-MM-yyyy - kk:mm').format(recentVideo.recentTime)}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          '${(recentVideo.totalLength != 0 ? (recentVideo.watchedLength / recentVideo.totalLength * 100).toStringAsFixed(1) : 0)}%',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
